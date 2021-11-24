#!/usr/bin//env zsh

fpath=($DOTFILES/zsh/plugins $fpath)

#launch tmux at startup
if [ "$TMUX" = "" ]; then tmux; fi
# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD			# Go to the folder path without cd

setopt AUTO_PUSHD		# Push the current directory visited on the stack
setopt PUSHD_IGNORE_DUPS	# Do not store duplicates in the stack
setopt PUSHD_SILENT		# Do not print the directory stack after push or popd

# Directory Stack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Jumping to a parent directory easily
autoload -Uz bd; bd

# +--------+
# | PROMPT |
# +--------+

# Load custom prompt config
fpath=($DOTFILES/zsh/prompt $fpath)
autoload -Uz prompt_purification_setup; prompt_purification_setup 

# +-----+
# | VIM |
# +-----+

# Activation Vi Mode	
bindkey -v
export KEYTIMEOUT=1

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

# Vim Mapping for Completion
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Editing Command Line in Vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Changing Cursor
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursors
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

# If you have a problem with End and Home key
#    zle-line-init () {
#       # Default zle-line-init
#       if (( $+terminfo[smkx] ))
#       then
#               echoti smkx
#       fi
#       zle editor-info
#
#       # Modify cursor!
#       zle -K viins
#   }
#
    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# +------------+
# | COMPLETION |
# +------------+

source $DOTFILES/zsh/completion.zsh

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# Command Completion
fpath=($DOTFILES/zsh/plugins/zsh-completions/src $fpath)

# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+

# Syntax HighLighting
source $DOTFILES/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

