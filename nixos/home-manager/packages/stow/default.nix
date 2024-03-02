{pkgs, ...}: {
  home.packages = [pkgs.stow];
  # programs.stow = {
  #   enable = true;
  # };
}
