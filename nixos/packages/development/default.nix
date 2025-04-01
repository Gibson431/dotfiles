{ pkgs, lib, ... }:
with pkgs;
let
  tools = [
    alejandra
    rustup
    nodejs
    taplo
    nixfmt-classic
    stylua
    fzf
    git
    git-lfs
    helix
    wl-clipboard
    tmux
    tmux-sessionizer
    direwolf
    gdb
    direnv
  ];
  packages = [ glibcLocales wget ffmpeg texliveFull ];
in {
  imports = [ ./python.nix ];
  environment.systemPackages = tools ++ packages;
}
