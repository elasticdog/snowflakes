# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, home-manager, lib, nixos-hardware, pkgs, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
    nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2

    ./hardware-configuration.nix
    ./hotkey-functions.nix
    ../../modules/common.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "auto";
    systemd-boot.memtest86.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/c4e9dd7e-7f4a-457c-80cc-33db52e34194";
      preLVM = true;
      allowDiscards = true;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abs = import ../../home/abs/holystone.nix;

  networking.hostName = "holystone";
  networking = {
    useDHCP = false;
    interfaces.enp2s0f0.useDHCP = false;
    interfaces.enp5s0.useDHCP = true;
  };
  networking.networkmanager.unmanaged = [ "enp2s0f0" ];

  # enable periodic SSD TRIM of mounted partitions in background
  services.fstrim.enable = true;

  # what to do when the laptop lid is closed
  # or the power button is short-pressed
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
    '';
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=3h";

  # optimize laptop battery life
  services.tlp.enable = true;

  time.timeZone = lib.mkForce "America/Los_Angeles";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
