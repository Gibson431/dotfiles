#!/bin/env bash

if [ -f $HOME/.cargo/env ]; then
	. "$HOME/.cargo/env"
fi

if command -v direnv 2>&1 >/dev/null; then
    eval "$(direnv hook bash)"
fi

if command -v starship 2>&1 >/dev/null; then
    eval "$(starship init bash)"
fi
