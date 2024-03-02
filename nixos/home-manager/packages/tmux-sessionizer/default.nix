{pkgs, ...}: {
  home.packages = [pkgs.tmux-sessionizer];
  # programs.tmux-sessionizer = {
  #   enable = true;
  # };
}
