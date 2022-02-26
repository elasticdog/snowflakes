{
  programs.fish = {
    enable = true;

    # autostart sway after user login
    loginShellInit = ''
      if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sway
      end
    '';
  };
}
