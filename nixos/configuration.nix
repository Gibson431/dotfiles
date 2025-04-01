{ config, pkgs, lib, ... }: {
  # imports = [];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 26214400;
    "net.core.rmem_default" = 26214400;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
  # services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

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

  # Enable DLL
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    # Add any missing DLL for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

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
  # 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
