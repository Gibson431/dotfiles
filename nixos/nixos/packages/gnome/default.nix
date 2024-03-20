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

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  # services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
}
