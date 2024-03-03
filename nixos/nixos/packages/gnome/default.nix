{pkgs, ...}: let
  gnome = with pkgs.gnome; [
    gnome-boxes
    gnome-tweaks
  ];

  extensions = with pkgs.gnomeExtensions; [
    tiling-assistant
  ];
in {
  environment.systemPackages = gnome ++ extensions;
}
