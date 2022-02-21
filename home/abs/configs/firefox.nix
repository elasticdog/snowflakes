{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    profiles = {
      work = {
        id = 0;
        isDefault = true;
      };

      home = {
        id = 1;
      };

      compatibility = {
        id = 2;
      };
    };
  };
}
