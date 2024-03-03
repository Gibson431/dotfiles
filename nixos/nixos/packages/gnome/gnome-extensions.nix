{pkgs, ...}: {
  programs.gnome.gnome-tweaks = {
    enable = true;
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    tiling-assistant
  ];
}
