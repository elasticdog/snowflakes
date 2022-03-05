{ config, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users = {
    abs = import ../home/abs/${config.networking.hostName}.nix;
  };
}
