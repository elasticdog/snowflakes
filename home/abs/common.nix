{ pkgs, ... }:

{
  imports = [
    ./configs/bat
    ./configs/direnv
    ./configs/firefox
    ./configs/fish
    ./configs/flameshot
    ./configs/git
    ./configs/glances
    ./configs/gpg
    ./configs/kakoune
    ./configs/kitty
    ./configs/lf
    ./configs/obs-studio
    ./configs/ripgrep
    ./configs/skim
    ./configs/sway
    ./configs/swayidle
    ./configs/tig
    ./configs/tridactyl
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
    fd
    glow
    gron
    helix
    hyperfine
    jless
    jq
    nixpkgs-fmt
    nodePackages.prettier
    pamixer
    pastel
    pavucontrol
    qalculate-gtk
    shellcheck
    shfmt
    spotify
    sshpass
    tree
    vault
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
