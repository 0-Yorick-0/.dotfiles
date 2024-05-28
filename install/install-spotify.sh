#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/spotifyd" ]; then
	mkdir "$XDG_CONFIG_HOME/spotifyd"
fi

ln -sf "$DOTFILES/spotify/spotifyd.conf" "$XDG_CONFIG_HOME/spotifyd/spotifyd.conf"
ln -sf "$DOTFILES/spotify/theme.toml" "$XDG_CONFIG_HOME/spotify-player/theme.toml"
