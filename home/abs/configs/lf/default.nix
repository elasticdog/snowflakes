{ pkgs, ... }:

{
  programs.lf = {
    enable = true;

    keybindings = {
      "," = "updir";
      "<esc>" = "quit";
    };

    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh
      unset COLORTERM
      bat --color=always "$1"
    '';

    settings = {
      hidden = true;
      icons = true;
      incsearch = true;
      scrolloff = 2;
    };
  };
}
