{ config, lib, pkgs, modulesPath, ... }:
let
  nix-gaming = import (builtins.fetchTarball
    "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  imports = [ ./nvidia.nix ];

  networking.hostName = "nixos-pc"; # Define your hostname.
  services.desktopManager.cosmic.enable = true;

  # Star citizen https://wiki.nixos.org/wiki/Star_Citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024; # 8 GB Swap
  }];
  zramSwap = {
    enable = true;
    memoryMax = 32 * 1024 * 1024 * 1024; # 16 GB ZRAM
  };

  users.users.main = {
    packages = with pkgs;
      [
        # tricks override to fix audio
        # see https://github.com/fufexan/nix-gaming/issues/165#issuecomment-2002038453
        (nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen.override {
          tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
        })
      ];
  };
}
