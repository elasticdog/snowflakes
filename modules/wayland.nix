{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [ bemenu swayidle swaylock ];
  };

  # allow for screen sharing
  xdg.portal.wlr.enable = true;
}
