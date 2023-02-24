#!/usr/bin/env bash

mkdir -p $ZDOTDIR

ln -sf $DOTFILES/zsh/.zshenv $HOME/.zshenv
ln -sf $DOTFILES/zsh/.zshrc $ZDOTDIR/.zshrc
#ls -sf /Users/yferlin/.config/local/share/nvim/site/pack/packer/opt/phpactor/bin/phpactor $HOME/bin/phpactor


source $DOTFILES/zsh/.zshrc
