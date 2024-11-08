{ pkgs, ... }: {
  home.packages = with pkgs; [
    zoom-us
    tmux
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
