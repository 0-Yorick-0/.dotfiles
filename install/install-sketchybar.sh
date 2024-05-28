#!/bin/sh

brew tap FelixKratz/formulae
brew install sketchybar

brew install font-hack-nerd-font
brew install font-sf-pro
brew install --cask sf-symbols

# skeytchybar font
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

ln -sF "$DOTFILES/sketchybar" "$XDG_CONFIG_HOME/sketchybar"
chmod -R +x "$XDG_CONFIG_HOME/sketchybar"
