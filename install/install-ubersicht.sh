#!/bin/sh

brew install switchaudio-osx
brew install nowplaying-cli

brew install font-hack-nerd-font
brew install font-sf-mono
brew install font-sf-pro
brew install --cask sf-symbols

brew install --cask ubersicht

if [ ! -d "$DOTFILES/ubersicht" ]; then
	mkdir "$DOTFILES/ubersicht"
fi

if [ ! -d "$DOTFILES/ubersicht/widgets" ]; then
	mkdir "$DOTFILES/ubersicht"
	git clone git@github.com:Jean-Tinland/simple-bar.git ~/.dotfiles/ubersicht/widgets/simple-bar
fi

brew services start ubersicht
