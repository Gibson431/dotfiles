{ config, lib, pkgs, modulesPath, ... }:
let
  nix-gaming = import (builtins.fetchTarball
    "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  imports = [ ./nvidia.nix ];

  networking.hostName = "nixos-pc"; # Define your hostname.

  # Star citizen https://wiki.nixos.org/wiki/Star_Citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
  boot.kernelPackages = pkgs.linuxPackages_6_11;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024; # 8 GB Swap
  }];
  zramSwap = {
    enable = true;
    memoryMax = 32 * 1024 * 1024 * 1024; # 16 GB ZRAM
  };
}
