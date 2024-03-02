{pkgs, ...}: {
  home.packages = [pkgs.gqrx];
  # programs.gqrx = {
  #   enable = true;
  # };
}
