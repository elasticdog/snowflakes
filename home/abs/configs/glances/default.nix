{ pkgs, ... }:

{
  home.packages = [ pkgs.glances ];

  xdg.configFile.glances_config = {
    source = ./glances.conf;
    target = "glances/glances.conf";
  };
}
