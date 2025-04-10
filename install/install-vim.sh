#!/bin/sh

brew install neovim

brew install php-cs-fixer
brew install composer
brew install prettier
brew install stylua
brew install gofumpt
brew install luarocks

MY_NEOVIM=~/.config/nvim-default
export MY_NEOVIM

rm -rf "$MY_NEOVIM"

mkdir -p "$MY_NEOVIM"/share
mkdir -p "$MY_NEOVIM"/nvim

# create symlinks between .dotfiles.nvim and ~/.config/nvim thanks to stow
stow --restow --target="$MY_NEOVIM"/nvim nvim

alias mnv='XDG_DATA_HOME=$MY_NEOVIM/share XDG_CACHE_HOME=$MY_NEOVIM XDG_CONFIG_HOME=$MY_NEOVIM nvim'

# creating spell dir & symlinks with dictionaries
if [[ ! -d "$MY_NEOVIM/spell" ]]; then
	mkdir "$MY_NEOVIM/spell"
	mkdir "$MY_NEOVIM/dictionaries"
fi
ln -sF "$DOTFILES/nvim/spell" "$MY_NEOVIM"
ln -sF "$DOTFILES/dictionaries" "$MY_NEOVIM"

if [[ ! -d "$MY_NEOVIM/after" ]]; then
	mkdir "$MY_NEOVIM/after"
fi
ln -sF "$DOTFILES/nvim/after" "$MY_NEOVIM"
# Install all mandatory folders if they don't exist already
mkdir -p "$MY_NEOVIM/undo"

# phpactor config file
if [[ ! -d "$XDG_CONFIG_HOME/nvim-default/share/nvim/mason/packages/phpactor" ]]; then
	mkdir "XDG_CONFIG_HOME/nvim-default/share/nvim/mason/packages/phpactor"
fi
ln -sf "$DOTFILES/phpactor/phpactor.json" "$XDG_CONFIG_HOME/nvim-default/share/nvim/mason/packages/phpactor/phpactor.json"

# yamlfmt config file
if [ ! -d "$XDG_CONFIG_HOME/yamlfmt" ]; then
	mkdir "$XDG_CONFIG_HOME/yamlfmt"
fi

ln -sf "$DOTFILES/language-server/.yamlfmt" "$XDG_CONFIG_HOME/yamlfmt/.yamlfmt"
