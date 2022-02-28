{ pkgs, ... }:

{
  home.packages = [ pkgs.yamllint ];

  xdg.configFile.yamllint_config = {
    source = ./config;
    target = "yamllint/config";
  };
}
