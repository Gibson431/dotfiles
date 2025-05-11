{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      # follows = "nixos-cosmic/nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic, ... }:
    let
      common-modules = [ ./configuration.nix ./packages ];

      hardware-module = [ /etc/nixos/hardware-configuration.nix ];

      cosmic-module = [
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [
              "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
            ];
          };
          services.desktopManager.cosmic.enable = true;
          # services.displayManager.cosmic-greeter.enable = true;
        }
        nixos-cosmic.nixosModules.default
      ];

    in {
      nixosConfigurations.banksy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = common-modules ++ hardware-module
          ++ [ ./de/hypr.nix ./hardware/banksy-configuration.nix ];
      };
      nixosConfigurations.midnight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = common-modules ++ hardware-module ++ cosmic-module
          ++ [ ./de/gnome.nix ./hardware/midnight-configuration.nix ];
      };
    };
}
