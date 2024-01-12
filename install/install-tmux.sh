#!/bin/sh

if [ ! -d "$XDG_CONFIG_HOME/tmux" ]; then
	mkdir "$XDG_CONFIG_HOME/tmux"
fi

if [ ! -d "$XDG_CONFIG_HOME/tmuxp" ]; then
	mkdir "$XDG_CONFIG_HOME/tmuxp"
fi

ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -sf "$DOTFILES/tmux/ssh-agent.sh" "$XDG_CONFIG_HOME/tmux/ssh-agent.sh"
chmod +x "$XDG_CONFIG_HOME/tmux/ssh-agent"
ln -sf "$DOTFILES/tmuxp/start.yaml" "$XDG_CONFIG_HOME/tmuxp/start.yaml"

tmux -f "$DOTFILES/tmux/tmux.conf"

if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
fi
