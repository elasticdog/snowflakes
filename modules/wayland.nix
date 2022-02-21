{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [ bemenu swayidle swaylock wl-clipboard ];
  }

  # allow for screen sharing
  xdg.portal.wlr.enable = true;
}
