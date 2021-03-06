{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      bemenu
      j4-dmenu-desktop
      swayidle
      swaylock
      wl-clipboard
      wdisplays
    ];
  };

  fonts.fonts = with pkgs; [
    iosevka
    fira-code
    font-awesome
    unicode-emoji
  ];

  # allow for screen sharing
  xdg.portal.wlr.enable = true;
}
