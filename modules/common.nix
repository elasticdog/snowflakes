{ pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./containers.nix
    ./flatpak.nix
    ./nix.nix
    ./services.nix
    ./users.nix
    ./wayland.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmpOnTmpfs = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  nixpkgs.config.allowUnfree = true;

  security.sudo.execWheelOnly = true;
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120
  '';

  time.timeZone = "UTC";
}
