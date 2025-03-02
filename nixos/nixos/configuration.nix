{ config, pkgs, lib, ... }: {
  # imports = [];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "modprobe.blacklist=dvb_usb_rtl28xxu" ];

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 26214400;
    "net.core.rmem_default" = 26214400;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable auto updates
  system.autoUpgrade = {
    enable = false;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "09:00";
    randomizedDelaySec = "45min";
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  # i18n.supportedLocales = ["en_AU.UTF-8/UTF-8"];
  # i18n.extraLocaleSettings = {};

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # services.xserver.displayManager.gdm = {
  #   enable = true;
  #   wayland = true;
  # };
  # services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "au";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages =
      (with pkgs; [ intel-media-driver intel-ocl intel-vaapi-driver ]);
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.main = {
    isNormalUser = true;
    description = "main";
    extraGroups =
      [ "networkmanager" "wheel" "docker" "kvm" "dialout" "lock" "uucp" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtaYVm8RCmHQCPhvfzJwxpF0rXGBBR5n27aRL1rAdXN"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.users.main = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "24.05";
  };

  # Enable DLL
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    # Add any missing DLL for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

    # lsp + compilers
    alejandra
    rustup
    gcc
    nodejs
    ccls
    taplo
    nixfmt

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
    kdenlive
    thunderbird
    stremio
    ryujinx
    arduino-ide
    stm32cubemx
  ]);

  services.flatpak.enable = true;

  # Change default programs
  # programs = {
  #   neovim = {
  #     enable = true;
  #     defaultEditor = true;
  #   };
  #   steam = {
  #     enable = true;
  #     remotePlay.openFirewall = true;
  #     dedicatedServer.openFirewall = true;
  #   };
  # };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  # networking.firewall = {
  #   allowedTCPPorts = [
  #     # warpinator
  #     42000
  #     42001
  #     # spotify local fs sync
  #     57621
  #     # calibre-web
  #     8083
  #   ];
  #   allowedUDPPorts = [
  #     # warpinator, spotify local discover
  #     5353
  #   ];
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
