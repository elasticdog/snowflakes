{
  imports = [
    ./fish_prompt.nix
    ./fish_right_prompt.nix
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # disable the welcome message
      set fish_greeting
    '';

    # autostart sway after user login
    loginShellInit = ''
      if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sway
      end
    '';

    shellAbbrs = {
      tree = "tree -F --dirsfirst";
    };
  };
}
