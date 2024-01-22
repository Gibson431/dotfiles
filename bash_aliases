#!/usr/bin/bash

export DOTFILES="$HOME/dotfiles/"

alias sb="source ~/.bashrc"
alias piob="pio run -t compiledb"
alias gs="git status"

edit_config() {
	directory=$PWD
	cd "$DOTFILES" || return
	nvim .
	cd "$directory" || return
}

alias ec="edit_config"

export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

