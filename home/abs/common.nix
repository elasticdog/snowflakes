{ pkgs, ... }:

{
  imports = [
    ./configs/direnv.nix
    ./configs/fish.nix
    ./configs/firefox.nix
    ./configs/flameshot.nix
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
    fd
    glances
    helix
    jless
    jq
    kakoune
    lf
    nixpkgs-fmt
    nodePackages.prettier
    pamixer
    pavucontrol
    qalculate-gtk
    ripgrep
    shellcheck
    shfmt
    skim
    spotify
    tig
    tree
    yamllint
    zathura
    zoom-us
  ];

  home.sessionVariables = {
    EDITOR = "kak";
  };
}
