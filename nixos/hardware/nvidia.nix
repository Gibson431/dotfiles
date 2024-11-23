{ config, lib, pkgs, modulesPath, ... }: {
  # imports = [];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    nvidia = {
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = true;
    };
  };

}
