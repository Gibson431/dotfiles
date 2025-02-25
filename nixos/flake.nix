{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, ... }:
    let
      common-modules =
        [ ./nixos home-manager.nixosModules.home-manager ./home-manager ];

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
          services.displayManager.cosmic-greeter.enable = true;
        }
        nixos-cosmic.nixosModules.default
      ];

    in {
      nixosConfigurations.banksy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = common-modules ++ hardware-module
          ++ [ ./de/gnome.nix ./hardware/banksy-configuration.nix ];
      };
      nixosConfigurations.midnight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = common-modules ++ hardware-module
          ++ [ ./de/gnome.nix ./hardware/midnight-configuration.nix ];
      };
    };
}
