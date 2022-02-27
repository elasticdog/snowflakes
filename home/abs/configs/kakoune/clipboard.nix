{
  programs.kakoune = {
    extraConfig = ''
      declare-option -hidden str system_clipboard_copy ""
      declare-option -hidden str system_clipboard_paste ""
      declare-option -hidden str system_clipboard_replace ""

      evaluate-commands %sh{
          case $(uname) in
              Linux) copy="wl-copy"; paste="wl-paste"; replace="wl-paste --no-newline"; ;;
              Darwin) copy="pbcopy"; paste="pbpaste"; replace="pbpaste"; ;;
          esac

          printf "map global user -docstring 'paste after from system clipboard' p '<a-!>%s<ret>'\n" "$paste"
          printf "map global user -docstring 'paste before from system clipboard' P '!%s<ret>'\n" "$paste"
          printf "map global user -docstring 'replace from system clipboard text' R '|%s<ret>'\n" "$replace"
          printf "map global user -docstring 'yank to system clipboard' y '<a-|>%s<ret>: echo -markup %%{{Information}copied selection to system clipboard}<ret>'\n" "$copy"

          printf "set-option global system_clipboard_copy '%s'\n" "$copy"
          printf "set-option global system_clipboard_paste '%s'\n" "$paste"
          printf "set-option global system_clipboard_replace '%s'\n" "$replace"
      }
    '';
  };
}
