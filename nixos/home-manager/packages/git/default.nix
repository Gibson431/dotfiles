{...}:{
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
}
