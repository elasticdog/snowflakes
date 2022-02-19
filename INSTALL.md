# NixOS Installation with Flakes

This will guide you through the steps I took to bootstrap a NixOS installation
using flakes from the beginning. The end goal is to have full disk encryption
using [LVM][]-on-[LUKS][].

> **WARNING:** These steps are not generic and some hardware assumptions have
> been made. Be careful when adapting these commands to your own installation,
> I'm mostly just writing this down for my own future reference.

[lvm]: https://en.wikipedia.org/wiki/Logical_volume_management
[luks]: https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup

## Prerequisites

1. Boot your machine from the latest available NixOS ISO (a USB flash drive
   works well).
2. Establish a [network connection][] within the installer.

   My wireless chip was not detected out of the box due to the ISO using an
   older kernel without a supported driver. Instead, I hooked up the laptop via
   an Ethernet cable and then waited for DHCP to assign it an address.

3. Become the `root` user by running the following command:

   ```
   [nixos@nixos:~]$ sudo -i
   ```

[network connection]:
  https://nixos.org/manual/nixos/stable/index.html#sec-installation-booting-networking

## Connect via SSH

> NOTE: This step is optional.

It can be easier to use an existing environnment to remote in and run the rest
of the setup. NixOS enables the SSH server daemon by default, but we'll need to
reset the `nixos` user's password before we can connect:

    [nixos@nixos:~]$ passwd
    Changing password for nixos.
    New password:
    Retype new password:
    passwd: password updated successfully

Check what the machine's IP address is by running:

    [nixos@nixos:~]$ ip addr
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: enp2s0f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
        link/ether 88:a4:c2:70:85:4e brd ff:ff:ff:ff:ff:ff
    3: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether 88:a4:c2:70:85:4d brd ff:ff:ff:ff:ff:ff
        inet 192.168.0.71/24 brd 192.168.0.255 scope global dynamic noprefixroute enp5s0
           valid_lft 85198sec preferred_lft 74398sec
        inet6 fe80::8aa4:c2ff:fe70:854d/64 scope link
           valid_lft forever preferred_lft forever

Then use that address to log in from another machine on your local network:

    $ ssh nixos@192.168.0.71
    The authenticity of host '192.168.0.71 (192.168.0.71)' can't be established.
    ED25519 key fingerprint is SHA256:1VuDIzswDHmUxFKsdxYNm7iwQupzFh3j0HUwOq0Gc54.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added '192.168.0.71' (ED25519) to the list of known hosts.
    (nixos@192.168.0.71) Password:

    [nixos@nixos:~]$

## Securely Wipe the Disk

Before encrypting the disk we would like to fill it with psuedo-random bits.
Depending on the size, this process can take over an hour to complete.

    [root@nixos:~]# lsblk
    NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0         7:0    0 702.1M  1 loop /nix/.ro-store
    sda           8:0    1  14.9G  0 disk
    ├─sda1        8:1    1   777M  0 part /iso
    └─sda2        8:2    1    37M  0 part
    nvme0n1     259:0    0 953.9G  0 disk
    └─nvme0n1p1 259:1    0 953.9G  0 part

    [root@nixos:~]# dd if=/dev/urandom of=/dev/nvme0n1 bs=64K oflag=direct status=progress
    dd: error writing '/dev/nvme0n1': No space left on device
    15628198+0 records in
    15628197+0 records out
    1024209543168 bytes (1.0 TB, 954 GiB) copied, 4326.83 s, 237 MB/s

## Partition and Format the Disk

First we'll create a GUID Partition Table (GPT) on the disk. Then we'll create
the unencrypted EFI system partition (ESP) for booting; note that the UEFI
specifications mandate that FAT32 be supported, so we use that for maximum
compatibility. Then we'll create a partition that spans the remainder of the
disk, since that will hold the LUKS container.

    [root@nixos:~]# parted /dev/nvme0n1
    GNU Parted 3.4
    Using /dev/nvme0n1
    Welcome to GNU Parted! Type 'help' to view a list of commands.
    (parted) mklabel gpt
    (parted) mkpart esp fat32 0% 1GiB
    (parted) mkpart crypted 1GiB 100%
    (parted) set 1 boot on
    (parted) print
    Model: UMIS RPETJ1T24MGE2QDQ (nvme)
    Disk /dev/nvme0n1: 1024GB
    Sector size (logical/physical): 512B/512B
    Partition Table: gpt
    Disk Flags:

    Number  Start   End     Size    File system  Name     Flags
     1      1049kB  1074MB  1073MB  fat32        esp      boot, esp
     2      1074MB  1024GB  1023GB               crypted

    (parted) quit
    Information: You may need to update /etc/fstab.

    [root@nixos:~]# mkfs.fat -F 32 -n EFIBOOT /dev/disk/by-partlabel/esp
    mkfs.fat 4.1 (2017-01-24)

## Create and Open the LUKS Container

This command will prompt for the password that will later be used to unlock the
laptop on boot.

    [root@nixos:~]# cryptsetup luksFormat /dev/disk/by-partlabel/crypted

    WARNING!
    ========
    This will overwrite data on /dev/disk/by-partlabel/crypted irrevocably.

    Are you sure? (Type 'yes' in capital letters): YES
    Enter passphrase for /dev/disk/by-partlabel/crypted:
    Verify passphrase:

We persist the `--allow-discards` configuration in the the LUKS2 metadata so it
will allow TRIM commands to be passed through to the disk even if we forget to
specify the option on future openings of the container.

> NOTE: There are [security implications][] of allowing TRIM, but it's not a
> huge deal for a laptop with this encryption setup and I prefer the performance
> benefit over the slim chance of minor metadata leakage.

    [root@nixos:~]# cryptsetup --allow-discards --persistent open --type luks /dev/disk/by-partlabel/crypted crypted
    Enter passphrase for /dev/disk/by-partlabel/crypted:

Now the container will be available at `/dev/mapper/crypted`

[security implications]:
  https://wiki.archlinux.org/index.php/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD)

## Configure LVM within the LUKS Container

Now we can initialize our LVM physical volume, and then create a volume group
and the logical volumes.

    [root@nixos:~]# pvcreate /dev/mapper/crypted
      Physical volume "/dev/mapper/crypted" successfully created.

    [root@nixos:~]# vgcreate myvg /dev/mapper/crypted
      Volume group "myvg" successfully created

    [root@nixos:~]# lvcreate -L 16G -n swap myvg
      Logical volume "swap" created.

    [root@nixos:~]# lvcreate -l 100%FREE -n root myvg
      Logical volume "root" created.

## Format the LVM Logical Volumes

Don't forget to lower the reserved-blocks-percentage (`-m`) to something lower
than the default 5% or it will take up a lot of space unneccessarily.

    [root@nixos:~]# mkfs.ext4 -L root -m 1 /dev/myvg/root
    mke2fs 1.46.5 (30-Dec-2021)
    Discarding device blocks: done
    Creating filesystem with 245590016 4k blocks and 61399040 inodes
    Filesystem UUID: 24cf6ffc-f0d2-4b35-a499-ecfe33f32761
    Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
        102400000, 214990848

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (262144 blocks): done
    Writing superblocks and filesystem accounting information: done

    [root@nixos:~]# mkswap -L swap /dev/myvg/swap
    Setting up swapspace version 1, size = 16 GiB (17179865088 bytes)
    LABEL=swap, UUID=0aaf64b1-eb35-4c83-b710-abdd1e40a6b3

## Mount the File Systems for Bootstrapping

    [root@nixos:~]# mount /dev/disk/by-label/root /mnt

    [root@nixos:~]# mkdir -p /mnt/boot

    [root@nixos:~]# mount /dev/disk/by-label/EFIBOOT /mnt/boot

    [root@nixos:~]# swapon /dev/disk/by-label/swap

## Generate Initial Config Files

First, we can output the normal generated hardware config to be stored in our
Git repository:

    [root@nixos:~]# nixos-generate-config --root /mnt --show-hardware-config

Then we need to sort out the other hardware-specific options for the LUKS
container mount. Let's find the UUID of the `nvme0n1p2` partition (NOT the
"crypted" LUKS partition) to ensure it gets automatically mounted at boot time:

    [root@nixos:~]# lsblk -o +UUID
    NAME            MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS    UUID
    loop0             7:0    0 702.1M  1 loop  /nix/.ro-store
    sda               8:0    1  14.9G  0 disk                 1980-01-01-00-00-00-00
    ├─sda1            8:1    1   777M  0 part  /iso           1980-01-01-00-00-00-00
    └─sda2            8:2    1    37M  0 part                 1234-5678
    nvme0n1         259:0    0 953.9G  0 disk
    ├─nvme0n1p1     259:1    0  1023M  0 part  /mnt/boot      A928-604C
    └─nvme0n1p2     259:2    0 952.9G  0 part                 c4e9dd7e-7f4a-457c-80cc-33db52e34194
      └─crypted     254:0    0 952.9G  0 crypt                rTdv57-JqPs-rDDU-ECqE-2IEf-96uw-l9n04a
        ├─myvg-swap 254:1    0    16G  0 lvm   [SWAP]         0aaf64b1-eb35-4c83-b710-abdd1e40a6b3
        └─myvg-root 254:2    0 936.9G  0 lvm   /mnt           24cf6ffc-f0d2-4b35-a499-ecfe33f32761

    [root@nixos:~]# blkid -o value -s UUID /dev/disk/by-partlabel/crypted
    c4e9dd7e-7f4a-457c-80cc-33db52e34194

Then add the following to the host-specific `configuration.nix` file based on
the above UUID:

```nix
boot.initrd.luks.devices = {
  crypted = {
    device = "/dev/disk/by-uuid/c4e9dd7e-7f4a-457c-80cc-33db52e34194";
    preLVM = true;
    allowDiscards = true;
  };
};
```

Let's also run weekly periodic TRIM commands `fstrim --all` by enabling the
service (which is better than running it continuously via the mount options)
within the host-specific `configuration.nix` file:

```nix
services.fstrim.enable = true;
```

> TODO: Document the steps for normal `configuration.nix` generation so we can
> get the appropriate boot loader and networking setup stored in our flake.

## Install via Flakes

Until `nix` 2.4.0 is used in the default ISO (it got reverted in NixOS 21.11),
the experimental flake features won't work as expected, so let's use `nix-shell`
to start a shell with the appropriate dependencies:

    [root@nixos:~]# nix-shell -p nixFlakes

Now we should be good to pull down our flake config from GitHub.

    [root@nixos:~]# nixos-install --no-root-passwd --cores 0 --flake github:elasticdog/snowflakes#holystone

## Reboot

Cross your fingers!

    [root@nixos:~]# reboot

## Verifying TRIM Configuration

To verify that you have configured TRIM correctly for LUKS, run:

    [root@nixos:~]# dmsetup table /dev/mapper/crypted
    0 1998278656 crypt aes-xts-plain64 :64:logon:cryptsetup:c4e9dd7e-7f4a-457c-80cc-33db52e34194-d0 0 259:2 32768 1 allow_discards

If this command output contains the string `allow_discards`, you have
successfully enabled TRIM on your LUKS device.

## Rescue Mode

If something went wrong and you need to boot into the installation NixOS ISO
again and mount these partitions, it only takes a few commands:

    [root@nixos:~]# cryptsetup open --type luks /dev/disk/by-partlabel/crypted crypted
    Enter passphrase for /dev/disk/by-partlabel/crypted:

    [root@nixos:~]# lvchange --activate y /dev/myvg/root

    [root@nixos:~]# lvchange --activate y /dev/myvg/swap

    [root@nixos:~]# mount /dev/disk/by-label/root /mnt

    [root@nixos:~]# mount /dev/disk/by-label/EFIBOOT /mnt/boot

    [root@nixos:~]# swapon /dev/disk/by-label/swap
