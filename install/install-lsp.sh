#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/yamlfmt" ]
	then
		mkdir "$XDG_CONFIG_HOME/yamlfmt"
fi

ln -sf "$DOTFILES/language-server/.yamlfmt" "$XDG_CONFIG_HOME/yamlfmt/.yamlfmt"
