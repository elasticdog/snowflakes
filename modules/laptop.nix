{
  imports = [
    ./audio.nix
    ./backups.nix
    ./printing.nix
    ./wayland.nix
    ./wifi.nix
  ];

  # optimize laptop battery life
  services.tlp.enable = true;
}
