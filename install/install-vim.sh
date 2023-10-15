#!/bin/sh

MY_NEOVIM=~/.config/my-neovim
export MY_NEOVIM

rm -rf "$MY_NEOVIM"

mkdir -p "$MY_NEOVIM"/share
mkdir -p "$MY_NEOVIM"/nvim

stow --restow --target="$MY_NEOVIM"/nvim nvim

alias mnv='XDG_DATA_HOME=$MY_NEOVIM/share XDG_CACHE_HOME=$MY_NEOVIM XDG_CONFIG_HOME=$MY_NEOVIM nvim'

# creating spell dir & symlinks with dictionaries
if [[ ! -d "$MY_NEOVIM/spell" ]]; then
        mkdir "$MY_NEOVIM/spell"
fi
ln -sF "$DOTFILES/nvim/spell" "$MY_NEOVIM"

# Install all mandatory folders if they don't exist already
mkdir -p "$MY_NEOVIM/undo"

# phpactor config file
if [[ ! -d "$XDG_CONFIG_HOME/phpactor" ]]; then
        mkdir "XDG_CONFIG_HOME/phpactor"
fi
ln -sf "$DOTFILES/phpactor/phpactor.json" "$XDG_CONFIG_HOME/phpactor/phpactor.json"

