{
  description = "nix system configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager }: {
    nixosConfigurations = {
      holystone = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # pin the system nixpkgs registry to our flake's revision
          { nix.registry.nixpkgs.flake = nixpkgs; }

          ./modules/common.nix
          ./hosts/holystone/configuration.nix

          nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abs = import ./home/abs/holystone.nix;
          }
        ];
      };
    };
  };
}
