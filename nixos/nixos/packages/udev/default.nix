{ pkgs, ... }: { services.udev.packages = with pkgs; [ openocd platformio ]; }
