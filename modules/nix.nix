{ nixpkgs, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc.automatic = true;
    gc.options = "--delete-older-than 30d";
    optimise.automatic = true;

    # pin the system nixpkgs registry to our flake's revision
    registry.nixpkgs.flake = nixpkgs;

    settings.allowed-users = [ "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
}
