#!/usr/bin/env bash
which brew
if [[ $? != 0 ]]; then
	echo "Homebrew is not installed, installing it now..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "putting brew in PATH"
	export PATH="$PATH:/opt/homebrew/bin"
fi
echo "Homebrew is already installed"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# useful Unix commands like gdate
brew install coreutils

# +-----------+
# | Mac Stuff |
# +-----------+
# better app launcher
brew install raycast
brew install stow
brew install alacritty
brew install borders
brew install chafa
brew install --cask zen-browser

# +-------+
# | Tools |
# +-------+
brew install wget
brew install jq
# yq is like jq but for yaml
# see https://github.com/mikefarah/yq
brew install yq
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
brew install orbstack
# testing framework for bash
brew install bats-core
brew install bat
brew install keychain
brew install grep
brew install ncdu

# +-------+
# | FONTS |
# +-------+
# see https://www.youtube.com/watch?v=mQdB_kHyZn8
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-symbols-only-nerd-font
brew install --cask font-jetbrains-mono
brew install --cask font-mononoki-nerd-font
brew install --cask font-powerline-symbols
brew install --cask font-menlo-for-powerline
brew install --cask font-devicons
brew install --cask font-awesome-terminal-fonts
brew install font-hack-nerd-font

# +----+
# | GO |
# +----+

brew install go
go install golang.org/x/tools/cmd/goimports@latest
#see https://github.com/google/yamlfmt
go install github.com/google/yamlfmt/cmd/yamlfmt@latest
brew install golangci-lint

# +------+
# | RUST |
# +------+
brew install rustup
brew install cargo

# +---------+
# | Git-Sim |
# +---------+

# dependancies for manim
# brew install py3cairo ffmpeg
# brew install pango scipy
#
# pip3 install manim
#
# # git-sim itself
# pip3 install git-sim

# Remove outdated versions from the cellar.
brew cleanup
#
# +------+
# | JAVA |
# +------+
brew install java11
sudo ln -sfn /opt/homebrew/Cellar/openjdk@11/11.0.24/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
