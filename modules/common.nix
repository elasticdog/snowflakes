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

  nix.settings.allowed-users = [ "@wheel" ];
  security.sudo.execWheelOnly = true;

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmpOnTmpfs = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    startWhenNeeded = true;
  };
}
