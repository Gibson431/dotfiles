{ pkgs, lib, ... }:
with lib;
let
  currentDir = ./.;
  files = dir:
    lib.attrsets.mapAttrsToList
    (name: value: if value == "directory" then "${name}" else null)
    (builtins.readDir dir);

  packages = dir: filter (file: !isNull file) (files dir);

  importDirectory = dir:
    let dirPath = "${currentDir}/${dir}";
    in if builtins.pathExists dirPath then import dirPath else { };

  importedPackages = builtins.map importDirectory (packages currentDir);
in {
  imports = importedPackages;

  environment.systemPackages = (with pkgs; [
    intel-gmmlib
    libvdpau-va-gl
    vaapiIntel
    vaapiVdpau
    x264
    openh264
    xorg.xhost

    virt-manager
    usbutils
    zlib
    pciutils
    libGL
    fontconfig
    libxkbcommon
    freetype
    dbus
    xsel
    nil
    gcc-arm-embedded
    xwayland
    stow
    tmux-sessionizer
    helix
    fastfetch
  ]);

  programs = {
    starship.enable = true;
    neovim.enable = true;
    direnv = {
      package = pkgs.direnv;
      silent = false;
      loadInNixShell = true;
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
  };
}
