{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = (with pkgs; [ gnome-boxes gnome-tweaks ])
    ++ (with pkgs.gnomeExtensions; [ tiling-assistant appindicator ]);

  environment.gnome.excludePackages = (with pkgs; [
    cheese # webcam tool
    gnome-photos
    gnome-tour
    gedit # text editor
    gnome-music
    gnome-terminal
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

}
