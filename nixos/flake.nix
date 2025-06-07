{
  description = "NixOS configuration";

  inputs = { nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; }; };

  outputs = { self, nixpkgs, ... }:
    let
      common-modules = [ ./configuration.nix ./packages ];
      hardware-module = [ /etc/nixos/hardware-configuration.nix ];
    in {
      nixosConfigurations.banksy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = common-modules ++ hardware-module ++ [
          ./de/gnome.nix
          ./de/hypr.nix
          ./hardware/banksy-configuration.nix
        ];
      };
      nixosConfigurations.midnight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = common-modules ++ hardware-module
          ++ [ ./de/gnome.nix ./de/hypr.nix ./hardware/midnight-configuration.nix ];
      };
    };
}
