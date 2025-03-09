#!/bin/sh

brew install starship

ln -sf "$DOTFILES/starship/starship.toml" "$XDG_CONFIG_HOME/starship.toml"
