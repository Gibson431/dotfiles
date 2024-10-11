{ config, 
  lib, 
  pkgs, 
  modulesPath, 
  ... 
}: {
  # imports = [];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
  };
}
