{ pkgs, ... }:

{
  imports = [
    ./common.nix

    ./configs/firefox
    ./configs/flameshot
    ./configs/kitty
    ./configs/obs-studio
    ./configs/sway
    ./configs/swayidle
    ./configs/tridactyl
    ./configs/waybar
    ./configs/wlsunset
  ];

  home.packages = with pkgs; [
    imv
    qalculate-gtk
    spotify
    zathura
    zoom-us
  ];

  xdg.dataFile.backgrounds = {
    recursive = true;
    source = ./backgrounds;
  };
}
