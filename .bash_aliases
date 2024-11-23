#!/usr/bin/bash

export DOTFILES="$HOME/dotfiles"

alias sb="source ~/.bashrc"
alias piob="pio run -t compiledb && pio init --ide vim"
alias gs="git status"
alias ns="nix-shell ."

edit-config() {
	cd "$DOTFILES" || return
	hx .
	cd "-" || return
}
alias ec="edit-config"

alias rebuild="rebuild.bash"

alias ehc="hx $DOTFILES/.config/helix/"

sau() {
	sudo apt update 
	sudo apt upgrade
	flatpak update
}

nix-update() {
	cd "$DOTFILES/nixos" || return
	# nix flake update
	sudo nixos-rebuild switch --flake .#$($HOSTNAME) --impure
	cd "-"
}
alias nu="nix-update"

edit-nix-config() {
	cd "$DOTFILES/nixos" || return 
	hx .
	cd "-"
}
alias enc="edit-nix-config"

# based on https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
project-cd() {
    selected=$(find $DOTFILES $HOME/Documents -type d -execdir 'test' '-d' '{}/.git' ';' -prune -print | fzf)
    cd "$selected"
}
alias pcd="project-cd"
