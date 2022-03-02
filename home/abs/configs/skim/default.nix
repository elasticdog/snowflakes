{ pkgs, ... }:

{
  home.packages = [ pkgs.skim ];

  home.sessionVariables = {
    SKIM_DEFAULT_COMMAND = "fd --type f --follow --hidden --exclude .git/ --strip-cwd-prefix";
    SKIM_DEFAULT_OPTIONS = "--color light";
  };
}
