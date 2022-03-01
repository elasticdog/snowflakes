{ config, pkgs, ... }:

{
  home.packages = [ pkgs.ripgrep ];

  home.sessionVariables = {
    RIPGREP_CONFIG_PATH = "$HOME/${config.xdg.configFile.ripgrep_config.target}";
  };

  xdg.configFile.ripgrep_config = {
    source = ./ripgreprc;
    target = "ripgrep/ripgreprc";
  };
}
