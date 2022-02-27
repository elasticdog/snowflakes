{
  programs.kakoune.config = {
    # "^[^*]+$" matches everything except built-in read-only buffers
    hooks = [
      {
        name = "BufCreate";
        option = ".*[.](hcl)";
        commands = ''
          set-option buffer filetype terraform"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=cue";
        commands = ''
          set-option window formatcmd "cue fmt --simplify -"
          set-option window lintcmd "cue vet -"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=fish";
        commands = ''
          set-option window formatcmd "fish_indent"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=git-(commit|rebase)";
        commands = ''
          autowrap-enable
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=go";
        commands = ''
          set-option window formatcmd "gofmt -s"
          set-option window lintcmd "golint"
          hook buffer BufWritePre .* %{
              go-format -use-goimports
              lint
          }
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=json";
        commands = ''
          set-option window formatcmd "prettier --parser json"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=jsonnet";
        commands = ''
          set-option window formatcmd "jsonnetfmt --string-style d -"
          hook buffer BufWritePre .* %{ format }
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=markdown";
        commands = ''
          set-option window formatcmd "prettier --parser markdown --prose-wrap always"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=nix";
        commands = ''
          set-option window formatcmd "nixpkgs-fmt"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=python";
        commands = ''
          set-option window formatcmd "black -"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=rust";
        commands = ''
          set-option window formatcmd "rustfmt"
          hook buffer BufWritePre .* %{ format }
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=sh";
        commands = ''
          set-option window formatcmd "shfmt -s"
          set-option window lintcmd "shellcheck --external-sources --format=gcc"
          hook buffer BufWritePre .* %{ lint }
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=terraform";
        commands = ''
          set-option window formatcmd "terraform fmt -"
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=yaml";
        commands = ''
          set-option window formatcmd "prettier --parser yaml"
          set-option window lintcmd "yamllint -f parsable"
          hook buffer BufWritePre .* %{ lint }
        '';
      }
      {
        name = "WinSetOption";
        option = "filetype=zig";
        commands = ''
          set-option window formatcmd "zig fmt --stdin"
        '';
      }
    ];
  };
}
