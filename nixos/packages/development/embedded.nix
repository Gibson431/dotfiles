{ pkgs, ... }:
with pkgs;
let
  tools = [ platformio gcc ccls clangd elf2uf2-rs probe-rs esptool ];
  packages = [ ];
in { environment.systemPackages = tools ++ packages; }
