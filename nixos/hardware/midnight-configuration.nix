{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ ./graphics/intel.nix ];

  networking.hostName = "midnight"; # Define your hostname.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  environment.systemPackages = [ pkgs.libinput ];
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024; # 8 GB Swap
  }];
  zramSwap = {
    enable = true;
    memoryMax = 32 * 1024 * 1024 * 1024; # 16 GB ZRAM
  };
}
