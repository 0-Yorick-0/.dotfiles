#!/usr/bin/env bash

if [ ! d "$XDG_CONFIG_HOME/yabai"]
    then
        mkdir "$XDG_CONFIG_HOME/yabai"
fi

if [ ! d "$XDG_CONFIG_HOME/skhd"]
    then
        mkdir "$XDG_CONFIG_HOME/skhd"
fi

ln -sf "$DOTFILES/yabai/yabairc" "$XDG_CONFIG_HOME/yabai/yabairc"
ln -sf "$DOTFILES/yabai/skhdrc" "$XDG_CONFIG_HOME/skhd/skhdrc"

