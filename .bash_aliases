#!/usr/bin/bash

export DOTFILES="$HOME/dotfiles"

alias sb="source ~/.bashrc"
alias piob="pio run -t compiledb && pio init --ide vim"
alias gs="git status"
alias ns="nix-shell ."
alias nd="nix develop"
alias nv="nvim"
alias j="just"

edit-config() {
	cd "$DOTFILES" || return
	nvim .
	cd "-" || return
}
alias ec="edit-config"

alias rebuild="rebuild.bash"

sau() {
	sudo apt update 
	sudo apt upgrade
	flatpak update
}

nix-update() {
	cd "$DOTFILES/nixos" || return
	# nix flake update
	sudo nixos-rebuild switch --flake .#$HOSTNAME --impure
	cd "-"
}
alias nu="nix-update"

nix-clean() {
	nix-collect-garbage &> /dev/null || echo "Failed to collect nix garbage"
	nix-store --gc &> /dev/null
}

edit-nix-config() {
	cd "$DOTFILES/nixos" || return 
	nvim .
	cd "-"
}
alias enc="edit-nix-config"

edit-hypr-config() {
	nvim "$HOME/.config/hypr/hyprland.conf" || return 
}
alias ehc="edit-hypr-config"

# based on https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
project-cd() {
    selected=$(find $DOTFILES $HOME/Documents -type d -execdir 'test' '-d' '{}/.git' ';' -prune -print | fzf)
    cd "$selected"
}
alias pcd="project-cd"
