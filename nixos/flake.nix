{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
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
  in {
    nixosConfigurations.nixos-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # specialArgs = {inherit unstable;};
      modules =common-modules ++ [./hardware/pc-configuration.nix];
    };
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # specialArgs = {inherit unstable;};
      modules = common-modules ++ [./hardware/zenbook-configuration.nix];
    };
  };
}
