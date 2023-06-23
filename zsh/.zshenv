#!/bin/zsh
########################
# EXPORT ENV VARIABLES #
########################

export TERM='screen'
export DOTFILES="$HOME/.dotfiles"

# check machine
[ -f $DOTFILES/check_os.zsh ] && machine=$(source $DOTFILES/check_os.zsh)
export CURRENT_MACHINE="${machine}"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000			# Max events for internal history
export SAVEHIST=10000			# Max events in history file

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# tmux
export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
case "${machine}" in
	Mac) export TMUX_COPY_PIPE_CONFIG='copy-pipe "reattach-to-user-namespace pbcopy"';;	
	Linux) export TMUX_COPY_PIPE_CONFIG='copy-pipe-and-cancel \"xsel --clipboard\"';;
	#Mac) export TMUX_COPY_PIPE_CONFIG='copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"';;	
	#Linux) export TMUX_COPY_PIPE_CONFIG='copy-pipe-and-cancel "xsel --clipboard"';;
	*) echo "Dude, I'm sorry, may be you should install reattach-to-user-namesapce if you're on mac ?";;
esac

# other software
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
# export COMPOSER="$XDG_CONFIG_HOME/composer"
