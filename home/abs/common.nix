{ pkgs, ... }:

{
  imports = [
    ./configs/direnv.nix
    ./configs/fish.nix
    ./configs/firefox.nix
    ./configs/flameshot.nix
    ./configs/gpg.nix
    ./configs/git.nix
    ./configs/kakoune.nix
    ./configs/kitty.nix
    ./configs/sway.nix
    ./configs/swayidle.nix
    ./configs/waybar.nix
    ./configs/wlsunet.nix
  ];

  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.username = "abs";
  home.homeDirectory = "/home/abs";

  home.packages = with pkgs; [
    bat
    bitwarden-cli
    editorconfig-core-c
    fd
    glances
    glow
    helix
    hyperfine
    jless
    jq
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

  xdg.dataFile.backgrounds = {
    recursive = true;
    source = ./backgrounds;
  };
}
