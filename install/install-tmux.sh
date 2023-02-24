#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/tmux" ]
	then
		mkdir "$XDG_CONFIG_HOME/tmux"
        git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
         "$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/install_plugins"
fi

if [ ! -d "$XDG_CONFIG_HOME/tmuxp" ]
    mkdir "$XDG_CONFIG_HOME/tmuxp"
fi

ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -sf "$DOTFILES/tmuxp/start.yaml" "$XDG_CONFIG_HOME/tmuxp/start.yaml"

tmux -f "$DOTFILES/tmux/tmux.conf"

if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ]
    then
        git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
fi

