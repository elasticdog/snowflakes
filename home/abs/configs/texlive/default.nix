{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (texlive.combine {
      inherit (texlive) scheme-small
        dejavu kpfonts libertine stix;
    })
  ];
}
