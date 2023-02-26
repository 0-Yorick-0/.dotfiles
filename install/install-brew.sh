#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# useful devtools 
brew install --cask devtoys

#use gawk instead of awk
brew install gawk

brew list python3 || brew install python3

# +----+
# | GO |
# +----+

brew install go
go install golang.org/x/tools/cmd/goimports@latest

# +---------+
# | NULL-LS |
# +---------+

brew install php-cs-fixer
brew install prettier
brew install stylua
brew install gofmt

# +---------+
# | Git-Sim |
# +---------+

# dependancies for manim
brew install py3cairo ffmpeg
brew install pango scipy

pip3 install manim

# git-sim itself
pip3 install git-sim
# +---------+
# | Spotify |
# +---------+

# CLI client for the GUI of Spotify 
# see https://medium.com/@baruchphillips/using-spotify-in-cli-e7d946c27b3e to configure it
brew install shpotify
# Spotify light client
brew install spotifyd
# Spotify client for the terminal
# see https://github.com/Rigellute/spotify-tui for install
brew install spotify-tui

# Remove outdated versions from the cellar.
brew cleanup
