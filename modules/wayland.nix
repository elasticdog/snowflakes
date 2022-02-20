{
  programs.sway.enable = true;

  # autostart sway after user login
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';

  # allow for screen sharing
  xdg.portal.wlr.enable = true;
}
