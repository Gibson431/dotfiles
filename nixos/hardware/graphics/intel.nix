{ config, lib, pkgs, modulesPath, ... }: {
  # imports = [];
  hardware.graphics = {
    enable = true;
    extraPackages =
      (with pkgs; [ intel-media-driver intel-ocl intel-vaapi-driver ]);
  };
}
