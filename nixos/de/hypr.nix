{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ ];

  programs.hyprland = { enable = true; };

  environment.systemPackages = with pkgs; [
    kitty
    hyprpaper
    kitty
    libnotify
    mako
    qt5.qtwayland
    qt6.qtwayland
    swayidle
    swaylock-effects
    wlogout
    wl-clipboard
    wofi
    waybar
  ];
}
