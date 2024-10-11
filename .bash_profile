export PATH=$PATH:$HOME/.local/scripts

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f $HOME/.cargo/env ]; then
	. "$HOME/.cargo/env"
fi
