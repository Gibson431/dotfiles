{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    obs-studio
  ];
  # programs.obs-studio = {
  #   enable = true;
  # };
}
