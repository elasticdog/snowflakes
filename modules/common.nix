{ pkgs, ... }:

{
  imports = [
    ./audio.nix
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
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=20
  '';

  time.timeZone = "UTC";
}
