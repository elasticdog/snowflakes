{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "abs";
  home.homeDirectory = "/home/abs";

  home.packages = with pkgs; [
    bat
    direnv
    fd
    iosevka
    kakoune
    kitty
    lf
    nixpkgs-fmt
    nodePackages.prettier
    ripgrep
    shellcheck
    shfmt
    skim
    tig
    tree
    yamllint
  ];

  programs.git = {
    enable = true;
    userName = "Aaron Bull Schaefer";
    userEmail = "aaron@elasticdog.com";
  };

  wayland.windowManager.sway = {
    enable = true;
    config.terminal = "kitty";
  };
}
