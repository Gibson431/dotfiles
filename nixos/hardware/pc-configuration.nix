{ config, 
  lib, 
  pkgs, 
  modulesPath, 
  ... 
}: {
  imports = [
    ./nvidia.nix
  ];

  networking.hostName = "nixos-pc"; # Define your hostname.
  services.desktopManager.cosmic.enable = true;
}
