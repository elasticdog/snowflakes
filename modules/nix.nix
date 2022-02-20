# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc.automatic = true;
    gc.options = "--delete-older-than 30d";
    optimise.automatic = true;

    settings.allowed-users = [ "@wheel" ];
  };
}
