#!/usr/bin/bash

export DOTFILES="$HOME/dotfiles"

alias sb="source ~/.bashrc"
alias piob="pio run -t compiledb && pio init --ide vim"
alias gs="git status"

edit_config() {
	directory=$PWD
	cd "$DOTFILES" || return
	nvim .
	cd "$directory" || return
}
alias ec="edit_config"

edit_vim_config() {
	directory=$PWD
	cd "$DOTFILES/.config/nvim" || return
	nvim .
	cd "$directory" || return
}
alias evc="edit_vim_config"

alias rebuild="rebuild.bash"

alias ehc="hx $DOTFILES/.config/helix/"

sau() {
	sudo apt update 
	sudo apt upgrade
	flatpak update
}

nix-update() {
	cd $DOTFILES/nixos
	nix flake update
	sudo nixos-rebuild switch --flake .#$($HOSTNAME) --impure
	cd -
}
alias nu="nix-update"