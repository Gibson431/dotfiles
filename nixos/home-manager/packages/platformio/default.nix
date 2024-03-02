{pkgs, ...}: {
  home.packages = [pkgs.platformio-core];
  # programs.platformio-core = {
  #   enable = true;
  # };
}
