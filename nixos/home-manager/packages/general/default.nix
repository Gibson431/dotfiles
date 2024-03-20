{pkgs, ...}: {
  home.packages = with pkgs; [
    zoom-us
    tmux
    tmux-sessionizer
    thunderbird
    unstable.stremio
    stow
    spotify
    unstable.ryujinx
    gqrx
    direwolf
    arduino
  ];
}
