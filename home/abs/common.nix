{ pkgs, ... }:

{
  imports = [
    ./configs/fish.nix
    ./configs/firefox.nix
    ./configs/git.nix
    ./configs/sway.nix
    ./configs/swayidle.nix
    ./configs/wlsunet.nix
  ];

  programs.home-manager.enable = true;
  home.username = "abs";
  home.homeDirectory = "/home/abs";

  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    bat
    bitwarden-cli
    direnv
    fd
    helix
    iosevka
    jq
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
    wlsunset
    yamllint
    zathura
    zoom-us
  ];
}
