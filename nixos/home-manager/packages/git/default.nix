{
  pkgs,
  lib,
  config,
  nixosConfig ? {},
  ...
}: {
  # programs.git = {
  #   # package = pkgs.gitAndTools.gitFull;
  #   enable = true;
  #   userName = "Gibson431";
  #   userEmail = "timmaxgibson@gmail.com";
  #   ignores = ["*~" "*.swp"];
  #   # includes = [{path = "~/.gitconfig.default";}];
  #   extraConfig = {
  #     core.editor = "hx";
  #     gpg.format = "ssh";
  #     gpg."ssh".program = lib.mkIf (nixosConfig != {} && nixosConfig.programs._1password-gui.enable && nixosConfig.programs._1password-gui.sshAgent) "${pkgs._1password-gui}/bin/op-ssh-sign";
  #     commit.gpgsign = true;
  #     user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEtaYVm8RCmHQCPhvfzJwxpF0rXGBBR5n27aRL1rAdXN";
  #     push.autoSetupRemote = true;
  #   };
  # };
}
