#!/usr/bin/env bash

if [ ! -d "$XDG_CONFIG_HOME/nvim" ]
	then
		mkdir "$XDG_CONFIG_HOME/nvim"
    
    # install neovim plugin manager
     git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

ln -sf "$DOTFILES/nvim/init.lua" "$VIMCONFIG"
ln -sF "$DOTFILES/nvim/after" "$VIMCONFIG"

# Install all mandatory folders if they don't exist already
mkdir -p "$VIMCONFIG/undo"

# configuration of different plugins
ln -sF "$DOTFILES/nvim/lua" "$VIMCONFIG"

# phpactor config file
if [ ! -d "$XDG_CONFIG_HOME/phpactor" ]
    then
        mkdir "XDG_CONFIG_HOME/phpactor"
fi
ln -sf "$DOTFILES/phpactor/phpactor.json" "$XDG_CONFIG_HOME/phpactor/phpactor.json"

