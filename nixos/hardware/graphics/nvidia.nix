{ config, lib, pkgs, modulesPath, ... }: {
  # imports = [];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
