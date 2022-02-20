{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "abs";
  home.homeDirectory = "/home/abs";

  home.packages = with pkgs; [
    kakoune
    nixfmt
    nodePackages.prettier
    shellcheck
    shfmt
    tflint
    tfsec
    yamllint
  ];

  programs.git = {
    enable = true;
    userName = "Aaron Bull Schaefer";
    userEmail = "aaron@elasticdog.com";
  };
}
