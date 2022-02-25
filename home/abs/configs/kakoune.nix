{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;

    config = {
      autoReload = "yes";

      hooks = [
        {
          name = "ModuleLoaded";
          option = "fzf";
          commands = "set-option global fzf_highlight_command bat";
        }
        {
          name = "ModuleLoaded";
          option = "fzf-file";
          commands = "set-option global fzf_file_command 'fd --type f --follow --hidden --exclude /.git/ --color never'";
        }
        {
          name = "ModuleLoaded";
          option = "fzf-grep";
          commands = "set-option global fzf_grep_command rg";
        }
        {
          name = "ModuleLoaded";
          option = "fzf-sk-grep";
          commands = "set-option global fzf_sk_grep_command 'rg --no-heading --follow --hidden --glob=!.git --color always'";
        }
        {
          name = "WinCreate";
          option = "^[^*]+$";
          commands = "editorconfig-load";
        }
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
