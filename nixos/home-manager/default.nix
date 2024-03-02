{...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.main = import ./main.nix;

  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
}
