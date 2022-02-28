{ pkgs, ... }:

{
  home.packages = [ pkgs.tig ];

  xdg.configFile.tig_config = {
    source = ./config;
    target = "tig/config";
  };
}
