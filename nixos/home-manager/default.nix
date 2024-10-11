{...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.main = {
    imports = [
      ./packages
    ];

    home.username = "main";
    home.homeDirectory = "/home/main";

    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.05";

    # Let home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
}
