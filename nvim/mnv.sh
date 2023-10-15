!#/bin/sh

MY_NEOVIM=~/.config/my-neovim
export MY_NEOVIM

alias mnv='XDG_DATA_HOME=$MY_NEOVIM/share XDG_CACHE_HOME=$MY_NEOVIM XDG_CONFIG_HOME=$MY_NEOVIM nvim'

mnv
