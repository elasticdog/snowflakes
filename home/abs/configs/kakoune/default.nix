{ pkgs, ... }:

{
  imports = [
    ./clipboard.nix
    ./explore.nix
    ./filetypes.nix
    ./hooks.nix
    ./key-mappings.nix
  ];

  home.packages = [ pkgs.editorconfig-core-c ];

  xdg.configFile.colorscheme_kakoune = {
    source = ../../colorscheme/kakoune.kak;
    target = "kak/colors/elasticdog.kak";
  };

  programs.kakoune = {
    enable = true;

    config = {
      autoReload = "yes";

      colorScheme = "elasticdog";

      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = true;
        separator = "'  '";
      };

      scrollOff.lines = 2;

      showMatching = true;

      showWhitespace = {
        enable = true;
        lineFeed = " ";
        space = " ";
        tab = "⏵";
        tabStop = "·";
      };

      tabStop = 4;

      ui = {
        assistant = "none";
      };

      wrapLines = {
        enable = true;
        indent = true;
        marker = "⏎";
        word = true;
      };
    };

    extraConfig = ''
      add-highlighter global/trailing-whitespace regex "\h+$" 0:default,red
      set-option global autowrap_column 80
      set-option global grepcmd 'rg --column --follow'
    '';

    plugins = [
      pkgs.kakounePlugins.kak-fzf
    ];
  };

  # only used by the fzf.kak plugin
  home.sessionVariables = {
    FZF_DEFAULT_OPTS = "--color light";
  };
}
