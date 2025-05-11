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
    kitty
    tmux
    stow
    helix
    fastfetch
    tmux-sessionizer
    direwolf
    direnv
    vscode
    ripgrep

    # dev tools
    clang
    clang-tools
    gcc
    ccls
    rust-analyzer
    gdb
  ];
  packages = [ glibcLocales wget ffmpeg texliveFull ];
in {
  imports = [ ./python.nix ];
  environment.systemPackages = tools ++ packages;
}
