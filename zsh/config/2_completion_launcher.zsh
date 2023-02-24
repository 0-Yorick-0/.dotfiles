#!/usr/bin/env zsh

# +------------+
# | COMPLETION |
# +------------+

source $DOTFILES/zsh/config/sources/completion.zsh

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# Command Completion
fpath=($DOTFILES/zsh/plugins/zsh-completions/src $fpath)

