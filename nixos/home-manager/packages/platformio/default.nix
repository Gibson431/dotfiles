{pkgs, ...}: {
  home.packages = [pkgs.unstable.platformio-core];
  # programs.platformio-core = {
  #   enable = true;
  # };
}
