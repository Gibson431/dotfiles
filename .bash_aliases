#!/usr/bin/bash

export DOTFILES="$HOME/dotfiles"

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

edit_vim_config() {
	directory=$PWD
	cd "$DOTFILES/.config/nvim" || return
	nvim .
	cd "$directory" || return
}
alias evc="edit_vim_config"

alias rebuild="rebuild.bash"

alias ehc="hx $DOTFILES/.config/helix/"
