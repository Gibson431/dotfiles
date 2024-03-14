{pkgs, ...}: {
  services.udev.packages = with pkgs; [
    openocd
    unstable.platformio
  ];
}
