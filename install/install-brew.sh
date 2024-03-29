#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# useful Unix commands like gdate
brew install coreutils

# useful devtools
brew install --cask devtoys

# +-----------+
# | Mac Stuff |
# +-----------+
# better terminal
brew install --cask iterm2
# better app launcher
brew install raycast
# window manager
brew install yabai
brew install skhd
brew install stow

# +-------+
# | Tools |
# +-------+
brew install wget
brew install jq
#use gawk instead of awk
brew install gawk
brew list python3 || brew install python3
brew in fd
brew install ripgrep
brew install tldr
brew install mkdocs
# run github actions locally
brew install act
brew install gh
brew install helm
source <(helm completion zsh)
brew install kubectl
source <(kubectl completion zsh)
brew install tree
brew install kubectx
brew install bash
brew install luarocks

# +-------+
# | FONTS |
# +-------+
# see https://www.youtube.com/watch?v=mQdB_kHyZn8
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-symbols-only-nerd-font
brew install --cask font-jetbrains-mono
brew install --cask homebrew/cask-fonts/font-powerline-symbols
brew install --cask homebrew/cask-fonts/font-menlo-for-powerline
brew install homebrew/cask-fonts/font-mononoki-nerd-font
brew install --cask font-devicons
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font

# +----+
# | GO |
# +----+

brew install go
go install golang.org/x/tools/cmd/goimports@latest
#see https://github.com/google/yamlfmt
go install github.com/google/yamlfmt/cmd/yamlfmt@latest
brew install golangci-lint
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
