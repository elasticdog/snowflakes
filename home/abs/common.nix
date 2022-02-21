{ pkgs, ... }:

{
  imports = [
    ./configs/fish.nix
    ./configs/git.nix
  ];

  programs.home-manager.enable = true;
  home.username = "abs";
  home.homeDirectory = "/home/abs";

  home.packages = with pkgs; [
    bat
    bitwarden-cli
    direnv
    fd
    firefox-wayland
    helix
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

  wayland.windowManager.sway = {
    enable = true;
    config.terminal = "kitty";
  };
}
