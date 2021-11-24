#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/tmux" ]
	then
		mkdir "$XDG_CONFIG_HOME/tmux"
fi

ln -sf "$DOTFILES/tmux/.tmux.conf" "$XDG_CONFIG_HOME/tmux"

tmux -f "$DOTFILES/tmux/.tmux.conf"
