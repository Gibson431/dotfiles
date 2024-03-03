{pkgs, ...}: {
  # programs.tmux = {
  #   enable = true;
  # };
  home.packages = [pkgs.tmux];
}
