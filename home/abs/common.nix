{ pkgs, ... }:

{
  imports = [
    ./configs/bat
    ./configs/direnv
    ./configs/fish
    ./configs/firefox
    ./configs/flameshot
    ./configs/gpg
    ./configs/git
    ./configs/kakoune
    ./configs/kitty
    ./configs/sway
    ./configs/swayidle
    ./configs/waybar
    ./configs/wlsunset
    ./configs/yamllint
  ];

  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.username = "abs";
  home.homeDirectory = "/home/abs";

  home.packages = with pkgs; [
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
    pastel
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
