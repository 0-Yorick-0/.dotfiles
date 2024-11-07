#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/wezterm" ]; then
	mkdir "$XDG_CONFIG_HOME/wezterm"
fi

ln -sf "$DOTFILES/wezterm/wezterm.lua" "$XDG_CONFIG_HOME/wezterm/wezterm.lua"
