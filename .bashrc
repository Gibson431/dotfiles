# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# User specific environment and startup programs
if [ -f $HOME/.cargo/env ]; then
	. "$HOME/.cargo/env"
fi

eval "$(starship init bash)"

source $HOME/.bash_aliases
tms config -p $HOME/Documents/git $HOME/dotfiles &>/dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/main/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/main/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/main/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/main/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

