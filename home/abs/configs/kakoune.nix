{ pkgs, ... }:

{
  xdg.configFile.colorscheme_kakoune = {
    source = ../colorscheme/kakoune.kak;
    target = "kak/colors/elasticdog.kak";
  };

  programs.kakoune = {
    enable = true;

    config = {
      autoReload = "yes";

      colorScheme = "elasticdog";

      # "^[^*]+$" matches everything except built-in read-only buffers
      hooks = [
        { name = "BufReload"; option = "^[^*]+$"; commands = "git update-diff"; }
        { name = "BufWritePost"; option = "^[^*]+$"; commands = "git update-diff"; }
        {
          # use jj to escape insert mode
          name = "InsertChar";
          option = "j";
          commands = ''
            try %{
              exec -draft hH <a-k>jj<ret> d
              exec <esc>
            }
          '';
        }
        {
          name = "WinCreate";
          option = "^[^*]+$";
          commands = ''
            editorconfig-load
            git show-diff
          '';
        }
        { name = "WinDisplay"; option = "^[^*]+$"; commands = "git update-diff"; }

        # fzf.kak plugin
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
      ];

      keyMappings = [
        { mode = "insert"; key = "<c-[>"; effect = "<esc>"; }
        { mode = "normal"; key = "<c-p>"; effect = ": fzf-mode<ret>f"; }
        { mode = "normal"; key = "/"; effect = "/(?i)"; } # case-insensitive search

        {
          mode = "normal";
          key = "=";
          docstring = "Format selection to a width of `autowrap_column` characters";
          effect = "|fmt -w $kak_opt_autowrap_column<ret>";
        }
      ];

      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = true;
        separator = "'  '";
      };

      showMatching = true;

      showWhitespace = {
        enable = true;
        lineFeed = " ";
        space = " ";
        tab = "➜";
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
}
