#!/usr/bin/bash

export DOTFILES="$HOME/dotfiles/"

alias sb="source ~/.bashrc"
alias piob="pio run -t compiledb"

edit_config() {
	directory=$PWD
	cd "$DOTFILES"
	nvim .
	cd directory
}

alias ec="edit_config"

