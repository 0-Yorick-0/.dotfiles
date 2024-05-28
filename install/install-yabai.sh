#!/bin/sh

# see https://www.josean.com/posts/yabai-setup
if [ ! -d "$XDG_CONFIG_HOME/yabai" ]; then
	mkdir "$XDG_CONFIG_HOME/yabai"
fi

if [ ! -d "$XDG_CONFIG_HOME/skhd" ]; then
	mkdir "$XDG_CONFIG_HOME/skhd"
fi

ln -sf "$DOTFILES/yabai/yabairc" "$XDG_CONFIG_HOME/yabai/yabairc"
ln -sf "$DOTFILES/yabai/skhdrc" "$XDG_CONFIG_HOME/skhd/skhdrc"

# then use yabai --start-service
# and skhd --start-service
