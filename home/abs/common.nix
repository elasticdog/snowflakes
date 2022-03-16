{ pkgs, ... }:

{
  imports = [
    ./configs/bat
    ./configs/direnv
    ./configs/fish
    ./configs/git
    ./configs/glances
    ./configs/gpg
    ./configs/kakoune
    ./configs/lf
    ./configs/ripgrep
    ./configs/skim
    ./configs/texlive
    ./configs/tig
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
    gnumake
    gmailctl
    gron
    helix
    hyperfine
    jless
    jq
    nixpkgs-fmt
    nodePackages.prettier
    pastel
    shellcheck
    shfmt
    sshpass
    tree
    treefmt
    vault
  ];

  home.sessionVariables = {
    EDITOR = "kak";
  };
}
