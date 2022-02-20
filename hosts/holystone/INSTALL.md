# Lenovo ThinkPad T14 Gen2 AMD Laptop Installation

## Change the BIOS Settings

Press `F1` on boot to enter the BIOS Setup...

1. Permanently Disable the "Absolute Persistence Module" under the _Security_
   menu. Then press `F10` to save and exit **before changing anything else**, as
   this will re-flash the BIOS to one without the remote backdoor software.

2. Disable "Secure Boot" under the _Security_ menu, as NixOS is not signed to
   where it would be supported.

3. Enable "TSME" under the _Security_ menu. This is AMD's Transparent Secure
   Memory Encryption and it can be handled directly rather than having to
   explicitly add a kernel parameter later.

4. Under the _Config_ -> _Power_ menu, switch the "Sleep State" from "Windows
   10" to "Linux".

5. Under the _Config_ menu, switch the "Setup UI" from "Graphical" to "Simple
   Text".

6. Press `F10` to save and exit.

On reboot, press `F12` to enter the boot menu, and select the USB drive with the
latest NixOS ISO installed on it.

## References

- [ArchWiki](<https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14_(AMD)_Gen_2>)
- [nixos-hardware](https://github.com/NixOS/nixos-hardware/tree/master/lenovo/thinkpad/t14/amd/gen2)
