!#/bin/sh

MY_NEOVIM=~/.config/nvim-default
export MY_NEOVIM

alias mnv='XDG_DATA_HOME=$MY_NEOVIM/share XDG_CACHE_HOME=$MY_NEOVIM XDG_CONFIG_HOME=$MY_NEOVIM nvim'

mnv
