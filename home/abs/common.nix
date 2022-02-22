{ pkgs, ... }:

{
  imports = [
    ./configs/fish.nix
    ./configs/firefox.nix
    ./configs/git.nix
    ./configs/kitty.nix
    ./configs/sway.nix
    ./configs/swayidle.nix
    ./configs/waybar.nix
    ./configs/wlsunet.nix
  ];

  programs.home-manager.enable = true;
  home.username = "abs";
  home.homeDirectory = "/home/abs";

  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "22.05";

  home.file.backgrounds = {
    source = ./backgrounds;
    target = ".local/share/backgrounds";
    recursive = true;
  };

  home.packages = with pkgs; [
    bat
    bitwarden-cli
    direnv
    fd
    helix
    jq
    kakoune
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
    zathura
    zoom-us
  ];
}
