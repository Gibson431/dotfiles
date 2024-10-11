{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-cosmic,
    ...
  }: let
    # overlay-unstable = final: prev: {
    #   unstable = nixpkgs-unstable.legacyPackages.${prev.system};
    #   # unstable = import nixpkgs-unstable {
    #   #   inherit system;
    #   #   config.allowUnfree = true;
    #   # };
    # };
    common-modules = [
      # ({...}: {nixpkgs.overlays = [overlay-unstable];})
      ./nixos
      home-manager.nixosModules.home-manager
      ./home-manager
    ];

    hardware-module = [
      /etc/nixos/hardware-configuration.nix
    ];

    cosmic-module = [
      {
        nix.settings = {
          substituters = [ "https://cosmic.cachix.org/" ];
          trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
        };
      }
      nixos-cosmic.nixosModules.default
    ];

  in {
    nixosConfigurations.nixos-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = common-modules ++ hardware-module ++ cosmic-module ++ [./hardware/pc-configuration.nix];
    };
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = common-modules ++ hardware-module ++ [./hardware/zenbook-configuration.nix];
    };
  };
}
