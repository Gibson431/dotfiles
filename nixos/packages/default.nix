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
    # libs
    graphviz
    python312
    python312Packages.numpy
    python312Packages.tkinter
    python312Packages.python-lsp-server
    python312Packages.setuptools
    python312Packages.pip
    tk
    glibcLocales
    wget
    ffmpeg
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
    texliveFull
    intel-gmmlib
    libvdpau-va-gl
    vaapiIntel
    vaapiVdpau
    x264
    openh264
    xorg.xhost
    gcc-arm-embedded
    direnv
    xwayland

    # lsp + compilers
    alejandra
    rustup
    gcc
    nodejs
    ccls
    taplo
    nixfmt-classic

    # tools
    elf2uf2-rs
    probe-rs
    esptool
    fzf
    git
    git-lfs
    helix
    platformio
    wl-clipboard
    stow
    tmux
    tmux-sessionizer
    direwolf
    gdb

    # apps
    fastfetch
    libreoffice
    spotify
    proton-pass
    protonvpn-gui
    gof5
    warpinator
    vlc
    libvlc
    obs-studio
    obsidian
    openrocket
    calibre
    davinci-resolve
    kdePackages.kdenlive
    thunderbird
    stremio
    ryujinx
    arduino-ide
    stm32cubemx
    vscode
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
