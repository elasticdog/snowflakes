{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      bemenu
      j4-dmenu-desktop
      swayidle
      swaylock
    ];
  };

  # allow for screen sharing
  xdg.portal.wlr.enable = true;
}
