{
  programs.kakoune.config = {
    keyMappings = [
      {
        mode = "insert";
        key = "<c-[>";
        docstring = "leave insert mode";
        effect = "<esc>";
      }
      {
        mode = "normal";
        key = "<c-g>";
        docstring = "grep file contents recursively";
        effect = ":grep ";
      }
      {
        mode = "normal";
        key = "<c-p>";
        docstring = "open files with fuzzy finder";
        effect = ": fzf-mode<ret>f";
      }
      {
        mode = "normal";
        key = "<minus>";
        docstring = "check the current buffer with a linter";
        effect = ": lint<ret>";
      }
      {
        mode = "normal";
        key = "'#'";
        docstring = "(un)comment seleted lines using line comments";
        effect = ": comment-line<ret>";
      }
      {
        mode = "normal";
        key = "/";
        docstring = "(case-insensitive) select next match after each selection";
        effect = "/(?i)";
      }
      {
        mode = "normal";
        key = "=";
        docstring = "format the contents of the buffer";
        effect = ": format<ret>";
      }

      # git mode
      {
        mode = "git";
        key = "b";
        docstring = "blame - show last modification info for each line of current file";
        effect = ": terminal tig blame -C \"+%val{cursor_line}\" -- \"%val{buffile}\"<ret>";
      }
      {
        mode = "git";
        key = "c";
        docstring = "commit - record changes to the repository";
        effect = ": git commit<ret>";
      }
      {
        mode = "git";
        key = "d";
        docstring = "diff - show changes between HEAD and working tree";
        effect = ": git diff<ret>";
      }
      {
        mode = "git";
        key = "l";
        docstring = "log - show commit logs for the current file";
        effect = ": terminal tig log -- \"%val{buffile}\"<ret>";
      }
      {
        mode = "git";
        key = "s";
        docstring = "status - show the working tree status";
        effect = ": terminal tig status<ret>";
      }
      {
        mode = "git";
        key = "t";
        docstring = "staged - show staged changes";
        effect = ": git diff --staged<ret>";
      }
      {
        mode = "git";
        key = "w";
        docstring = "write - write and stage the current file";
        effect = ": write<ret>: git add<ret>: git update-diff<ret>";
      }

      # user mode
      {
        mode = "user";
        key = ",";
        docstring = "explore the directory of the current file";
        effect = ": explore<ret>";
      }
      {
        mode = "user";
        key = "b";
        docstring = "open buffers with fuzzy finder";
        effect = ": fzf-mode<ret>b";
      }
      {
        mode = "user";
        key = "<a-b>";
        docstring = "delete buffers with fuzzy finder";
        effect = ": fzf-mode<ret><a-b>";
      }
      {
        mode = "user";
        key = "d";
        docstring = "delete current buffer";
        effect = ": delete-buffer<ret>";
      }
      {
        mode = "user";
        key = "g";
        docstring = "enable git keymap mode for next key";
        effect = ": enter-user-mode git<ret>";
      }
      {
        mode = "user";
        key = "q";
        docstring = "format selection to a width of `autowrap_column` characters";
        effect = "|fmt -w $kak_opt_autowrap_column<ret>";
      }
      {
        mode = "user";
        key = "s";
        docstring = "search in buffer with fuzzy finder";
        effect = ": fzf-mode<ret>s";
      }
      {
        mode = "user";
        key = "w";
        docstring = "write the current buffer to its file";
        effect = ": write<ret>";
      }
    ];
  };
}
