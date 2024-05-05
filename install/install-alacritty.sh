#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/alacritty" ]; then
	mkdir "$XDG_CONFIG_HOME/alacritty"
fi

git clone git@github.com:alacritty/alacritty-theme.git "$XDG_CONFIG_HOME/alacritty/theme"

ln -sf "$DOTFILES/alacritty/alacritty.toml" "$XDG_CONFIG_HOME/alacritty/alacritty.toml"
