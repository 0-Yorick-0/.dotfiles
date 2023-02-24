#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/spotifyd" ]
	then
		mkdir "$XDG_CONFIG_HOME/spotifyd"
fi

ln -sf "$DOTFILES/spotifyd/spotifyd.conf" "$XDG_CONFIG_HOME/spotifyd/spotifyd.conf"
