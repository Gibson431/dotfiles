{pkgs, ...}: {
  # home.packages = [pkgs.unstable.platformio-core];
  environment.systemPackages = with pkgs; [
    unstable.platformio-core
  ];

  services.udev.packages = with pkgs; [
    unstable.platformio-core
    openocd
  ];
  # programs.platformio-core = {
  #   enable = true;
  # };
}
