{ config, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users = {
    abs = import ../home/abs/holystone.nix;
  };
}
