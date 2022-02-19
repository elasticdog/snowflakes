{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "abs";
  home.homeDirectory = "/home/abs";

  home.packages = with pkgs; [
    kakoune
  ];

  programs.git = {
    enable = true;
    userName = "Aaron Bull Schaefer";
    userEmail = "aaron@elasticdog.com";
  };
}
