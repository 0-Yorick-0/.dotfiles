#!/bin/zsh
########################
# EXPORT ENV VARIABLES #
########################

# export TERM='screen-256color:RGB'
export DOTFILES="$HOME/.dotfiles"

# check machine
[ -f $DOTFILES/check_os.zsh ] && machine=$(source $DOTFILES/check_os.zsh)
export CURRENT_MACHINE="${machine}"

# ------------ XDG base directories --------------
# Centralizes config/cache/date locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_DATA_STATE="$XDG_CONFIG_HOME/local/state"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# ------------- ZSH -----------------------
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=100000			# Max events for internal history
export SAVEHIST=100000			# Max events in history file

# ------------ Editor ----------------------
# Default editor used by git, crontab etc...
export EDITOR="nvim"
export VISUAL="nvim"


# ------------- PATH -----------------------
# personal binaries scripts
export PATH="$HOME/.local/bin:$PATH"

# ------------- TMUX -----------------------
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
#. "$HOME/.cargo/env"
