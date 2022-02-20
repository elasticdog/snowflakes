# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./users.nix
    ./services.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmpOnTmpfs = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  nixpkgs.config.allowUnfree = true;

  security.sudo.execWheelOnly = true;
}
