{ pkgs, ... }:

{
  imports = [
    ./fish_prompt.nix
    ./fish_right_prompt.nix
    ./fish_user_key_bindings.nix
    ./gcd.nix
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # disable the welcome message
      set fish_greeting

      # use skim for fuzzy search shell integration
      #    Alt+c = change directory
      #   Ctrl+r = shell history
      #   Ctrl+t = file completion
      source "${pkgs.skim}/share/skim/key-bindings.fish"
      set -x SKIM_ALT_C_COMMAND "fd --type d --follow --hidden --exclude .git/ --strip-cwd-prefix"
      set -x SKIM_CTRL_T_COMMAND "fd --follow --hidden --exclude .git/ --strip-cwd-prefix"
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
