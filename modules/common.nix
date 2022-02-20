{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./users.nix
    ./services.nix
    ./wayland.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmpOnTmpfs = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  nixpkgs.config.allowUnfree = true;

  security.sudo.execWheelOnly = true;
}
