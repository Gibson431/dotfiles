{ config, pkgs, lib, ... }: {
  # imports = [
  # Include the results of the hardware scan.
  # ./hardware-configuration.nix
  # ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 26214400;
    "net.core.rmem_default" = 26214400;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable auto updates
  system.autoUpgrade = {
    enable = true;
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

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  # i18n.supportedLocales = ["en_AU.UTF-8/UTF-8"];
  # i18n.extraLocaleSettings = {};

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm = {
  #   enable = true;
  #   wayland = true;
  # };
  # services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
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

  hardware.graphics = { enable = true; };

  # services.udev.packages = with pkgs; [
  #   platformio-core
  #   openocd
  # ];

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
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "kvm"
      "dialout"
      "lock"
      "uucp"
      "plugdev"
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
  environment.systemPackages =
    # utils
    (with pkgs; [
      glibcLocales
      git
      git-lfs
      wget
      alejandra
      rustup
      gcc
      nodejs
      ccls
      elf2uf2-rs
      taplo
      fzf
      ffmpeg
      nixfmt
      virt-manager
      usbutils
      python3
      python310
      python310Packages.numpy
      python310Packages.tkinter
      python311Packages.pip
      python311Packages.stdenv
      python312
      python312Packages.numpy
      python312Packages.tkinter
      python312Packages.python-lsp-server
      graphviz
      tk
      zlib
      blueman
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
      intel-media-driver
      intel-ocl
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
      x264
      openh264
    ]) ++
    # apps
    (with pkgs; [
      # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      neofetch
      # _1password
      # _1password-gui
      # gnome.gnome-tweaks
      libreoffice
      spotify
      # gnome.gnome-boxes
      proton-pass
      protonvpn-gui
      platformio
      esptool
      helix
      gof5
      warpinator
      vlc
      libvlc
      obsidian
      openrocket
      calibre
      davinci-resolve
      kdenlive
      lutris
      # ssh
      # obs-studio
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

  fonts.packages = with pkgs; [ nerdfonts ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    allowedTCPPorts = [
      # warpinator
      42000
      42001
      #spotify local fs sync
      57621
    ];
    allowedUDPPorts = [
      # warpinator, spotify local discover
      5353
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
