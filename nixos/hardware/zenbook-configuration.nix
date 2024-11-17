{ config, lib, pkgs, modulesPath, ... }: {
  # imports = [];

  networking.hostName = "nixos-laptop"; # Define your hostname.
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  environment.systemPackages = [ pkgs.libinput ];
}
