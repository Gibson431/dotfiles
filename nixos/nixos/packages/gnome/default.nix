{pkgs, ...}: let
  gnome = with pkgs.gnome; [
    gnome-boxes
    gnome-tweaks
  ];

  extensions = with pkgs.gnomeExtensions; [
    tiling-assistant
    appindicator
  ];
in {
  environment.systemPackages = gnome ++ extensions;
  # services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
}
