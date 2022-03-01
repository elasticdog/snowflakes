{
  programs.fish.functions = {
    fish_right_prompt.body = ''
      set -l cmd_status $status
      if test $cmd_status -ne 0
          echo -n (set_color F1D9D6)''(set_color -b F1D9D6)(set_color red)'   '(fish_status_to_signal $cmd_status)' '
      end

      if test $CMD_DURATION
          # only display if it's been over 5 seconds
          if test $CMD_DURATION -gt (math "1000 * 5")
              set duration (humantime $CMD_DURATION)
              echo -n (set_color E3DCC0)''(set_color -b E3DCC0)(set_color yellow)" $duration "
          end
      end

      if not command -sq git
          set_color normal
          return
      end

      # Get the git directory for later use.
      # Return if not inside a Git repository work tree.
      if not set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
          set_color normal
          return
      end

      # Get the current action ("merge", "rebase", etc.)
      # and if there's one get the current commit hash too.
      set -l commit ""
      if set -l action (fish_print_git_action "$git_dir")
          set commit (command git rev-parse HEAD 2> /dev/null | string sub -l 7)
      end

      # Get either the branch name or a branch descriptor.
      set -l branch_detached 0
      if not set -l branch (command git symbolic-ref --short HEAD 2>/dev/null)
          set branch_detached 1
          set branch (command git describe --contains --all HEAD 2>/dev/null)
      end

      echo -n (set_color E0E1E1)''(set_color 7C7E85)(set_color -b E0E1E1)' '
      set_color -o

      if test -n "$branch"
          echo -n ' '
          if test $branch_detached -ne 0
              set_color brmagenta
          else
              set_color green
          end
          echo -n "$branch"
      end
      if test -n "$commit"
          echo -n ' '(set_color yellow)"$commit"
      end
      if test -n "$action"
          set_color normal
          echo -n (set_color white)':'(set_color -o brred)"$action"
      end
      echo -n ' '

      set_color normal
      source $HOME/.config/fish/functions/postexec_newline.fish
    '';

    # https://github.com/jorgebucaran/humantime.fish
    # Provided under the terms of the MIT License.
    # Copyright © Jorge Bucaran <https://jorgebucaran.com>
    humantime = {
      argumentNames = "ms";
      description = "Turn milliseconds into a human-readable string";
      body = ''
        set --query ms[1] || return

        set --local secs (math --scale=1 $ms/1000 % 60)
        set --local mins (math --scale=0 $ms/60000 % 60)
        set --local hours (math --scale=0 $ms/3600000)

        test $hours -gt 0 && set --local --append out $hours"h"
        test $mins -gt 0 && set --local --append out $mins"m"
        test $secs -gt 0 && set --local --append out $secs"s"

        set --query out && echo $out || echo $ms"ms"
      '';
    };

    postexec_newline = {
      onEvent = "fish_postexec";
      body = "echo";
    };
  };
}
