#!/bin/sh

brew install tmux
brew install tmuxp
# for copy-paste compatibility with tmux and alacritty
brew install reattach-to-user-namespace

if [ ! -d "$TMUX_CONFIG_DIR" ]; then
	mkdir "$TMUX_CONFIG_DIR"
fi
ln -sf "$DOTFILES/tmux/tmux.conf" "$TMUX_CONFIG_DIR/tmux.conf"

if [ ! -d "$TMUX_CONFIG_DIR/tmuxp" ]; then
	echo "Creating config directory for tmuxp"
	mkdir "$TMUX_CONFIG_DIR/tmuxp"
else
	echo "Well, tmuxp config directory already exists"
fi

ln -sf "$DOTFILES/tmux/start.yaml" "$TMUX_CONFIG_DIR/tmuxp/start.yaml"

ln -sf "$DOTFILES/tmux/ssh-agent.sh" "$TMUX_CONFIG_DIR/ssh-agent.sh"
chmod +x "$TMUX_CONFIG_DIR/ssh-agent.sh"

if [ ! -d "$TMUX_CONFIG_DIR/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm "$TMUX_CONFIG_DIR/plugins/tpm"
fi

tmux -f "$TMUX_CONFIG_DIR/tmux.conf"

# /!\ DON'T FORGET TO INSTALL TPM PLUGINS
# RUN TMUX AND PRESS `PREFIX + I` TO INSTALL PLUGINS
