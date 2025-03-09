#!/bin/sh

brew install switchaudio-osx
brew install nowplaying-cli

brew tap FelixKratz/formulae
brew install sketchybar

brew install font-hack-nerd-font
brew install font-sf-mono
brew install font-sf-pro
brew install --cask sf-symbols

# skeytchybar font
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# SbarLua (lua api for sketchybar)
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

if [ ! -d "$XDG_CONFIG_HOME/sketchybar" ]; then
	mkdir "$XDG_CONFIG_HOME/sketchybar"
fi

ln -sF "$DOTFILES/sketchybar" "$XDG_CONFIG_HOME"
chmod -R +x "$XDG_CONFIG_HOME/sketchybar"

brew services start sketchybar
