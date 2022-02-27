{
  programs.kakoune = {
    extraConfig = ''
      define-command explore \
          -params ..1 -file-completion \
          -docstring "explore [<path>]: explore the directory of the current file
          The optional path argument will override the initial location" \
          %{ evaluate-commands %sh{
              if [ $# -ge 1 ] && [ -e $1 ]; then
                  path=$1
              elif [ -f $kak_buffile ]; then
                  path=$kak_buffile
              else
                  path="$PWD/"
              fi
              printf 'explore-terminal "%s"\n' "$path"
          }
      }

      define-command -hidden explore-terminal \
          -params ..1 -file-completion \
          %{ evaluate-commands %{
              terminal sh -c "
                  export kak_session='%val{session}'
                  export kak_client='%val{client}'
                  %val{config}/scripts/explore.sh %arg(1)
              "
          }
      }
    '';
  };

  xdg.configFile.kakoune_explore_script = {
    source = ./explore.sh;
    target = "kak/scripts/explore.sh";
    executable = true;
  };
}
