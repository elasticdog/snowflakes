# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./users.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nix.allowedUsers = [ "@wheel" ];

  time.timeZone = "America/Los_Angeles";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    startWhenNeeded = true;
  };
}
