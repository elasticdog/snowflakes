{ pkgs, ... }:

{
  home.packages = [ pkgs.ripgrep ];

  xdg.configFile.ripgrep_config = {
    source = ./ripgrep.conf;
    target = "ripgrep/ripgrep.conf";
  };
}
