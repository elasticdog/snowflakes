{
  programs.kakoune.config = {
    # "^[^*]+$" matches everything except built-in read-only buffers
    hooks = [
      {
        name = "BufOpenFifo";
        option = "-always '\\*grep\\*'";
        commands = ''
          map global normal "'" ": grep-next-match<ret>"
        '';
      }
      {
        name = "BufOpenFifo";
        option = "-always '\\*grep\\*'";
        commands = ''
          map global normal "<a-'>" ": grep-previous-match<ret>"
        '';
      }
      {
        name = "BufOpenFifo";
        option = "-always '\\*lint-output\\*'";
        commands = ''
          map global normal "'" ": lint-next-message<ret>"
        '';
      }
      {
        name = "BufOpenFifo";
        option = "-always '\\*lint-output\\*'";
        commands = ''
          map global normal "<a-'>" ": lint-previous-message<ret>"
        '';
      }
      {
        name = "BufReload";
        option = "^[^*]+$";
        commands = "git update-diff";
      }
      {
        name = "BufWritePost";
        option = "^[^*]+$";
        commands = "git update-diff";
      }
      {
        name = "WinCreate";
        option = "^[^*]+$";
        commands = ''
          editorconfig-load
          git show-diff
        '';
      }
      {
        name = "WinDisplay";
        option = "^[^*]+$";
        commands = "git update-diff";
      }

      # fzf.kak plugin
      {
        name = "ModuleLoaded";
        option = "fzf";
        commands = ''
          set-option global fzf_highlight_command bat
          set-option global fzf_use_main_selection false
        '';
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
  };
}
