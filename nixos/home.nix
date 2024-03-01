{
  config,
  pkgs,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = "main";
  home.homeDirectory = "/home/main";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    thunderbird
    google-chrome
    alacritty
    spotify
    stow
    tmux
    gqrx
    starship
    tmux-sessionizer
    vscode
    direwolf
  ];
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = "IdentityAgent ~/.1password/agent.sock";
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Tim Gibson";
    userEmail = "timmaxgibson@gmail.com";
    # includes = [{path = "~/.gitconfig.default";}];
    extraConfig = {
      core.editor = "nvim";
      gpg.format = "ssh";
      gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      commit.gpgsign = true;
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICgECjvqME2XcDTN8e9X9tGtj3yo4IU6rjm5m7SDo7dw";
    };
  };
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
