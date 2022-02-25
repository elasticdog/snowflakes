{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;

    config = {
      autoReload = "yes";

      hooks = [
        { name = "WinCreate"; option = "^[^*]+$"; commands = "editorconfig-load"; }
      ];

      keyMappings = [
        { mode = "insert"; key = "<c-[>"; effect = "<esc>"; }
        { mode = "normal"; key = "<c-p>"; effect = ": fzf-mode<ret>"; }
      ];

      numberLines = {
        enable = true;
        relative = true;
      };

      showMatching = true;
      tabStop = 4;

      ui = {
        assistant = "none";
      };
    };

    extraConfig = ''
      set-option global autowrap_column 80
      set-option global grepcmd 'rg --column --follow'
    '';

    plugins = [
      pkgs.kakounePlugins.kak-fzf
    ];
  };
}
