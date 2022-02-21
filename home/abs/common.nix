{ pkgs, ... }:

{
  imports = [
    ./configs/fish.nix
    ./configs/git.nix
    ./configs/sway.nix
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
    pamixer
    pavucontrol
    ripgrep
    shellcheck
    shfmt
    skim
    tig
    tree
    yamllint
  ];
}
