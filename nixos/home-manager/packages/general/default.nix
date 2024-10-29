{ pkgs, ... }: {
  home.packages = with pkgs; [
    zoom-us
    tmux
    tmux-sessionizer
    thunderbird
    stremio
    stow
    # spotify
    ryujinx
    gqrx
    direwolf
    arduino
  ];
}
