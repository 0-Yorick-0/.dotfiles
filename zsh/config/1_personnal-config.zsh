#!/usr/bin/env zsh

ssh-add --apple-use-keychain ~/.ssh/id_ed25519

export BAT_THEME="Dracula"

#update PATH
export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/Library/Python/3.9/bin/:$PATH"

export PATH="$HOME/go/bin/:$PATH"
# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD			# Go to the folder path without cd

setopt AUTO_PUSHD		# Push the current directory visited on the stack
setopt PUSHD_IGNORE_DUPS	# Do not store duplicates in the stack
setopt PUSHD_SILENT		# Do not print the directory stack after push or popd


# Jumping to a parent directory easily
autoload -Uz bd; bd

# +---------+
# | ALIASES |
# +---------+

source $DOTFILES/aliases/aliases

# +-----+
# | VIM |
# +-----+

MY_NEOVIM=~/.config/nvim-default
export MY_NEOVIM

alias mnv='XDG_DATA_HOME=$MY_NEOVIM/share XDG_CACHE_HOME=$MY_NEOVIM XDG_CONFIG_HOME=$MY_NEOVIM nvim'
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

# Add Vi text-objects for brackets & quotes
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
	bindkey -M $km -- '-' vi-up-line-or-history
	for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
		bindkey -M $km $c select-quoted
	done
	for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
		bindkey -M $km $c select-bracketed
	done
done


# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+

# Syntax HighLighting
source $DOTFILES/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# +------+
# | BREW |
# +------+

export PATH="$PATH:/opt/homebrew/bin"

# +------+
# | PHP  |
# +------+

export PATH="$PATH:/opt/homebrew/opt/php@7.4/bin/"
export PATH="$PATH:/opt/homebrew/opt/rabbitmq/sbin"


# +------+
# | FZF  |
# +------+

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border --layout reverse'
fi

# +------+
# | WALK |
# +------+

function lk {
  cd "$(walk "$@")"
}

# +-------------+
# | BIG LETTERS |
# +-------------+

big_letters() {
    arg="$1"
    echo $1 | sed -r 's/(\w)/:alphabet_yellow_\1:/g' | sed 's/ /      /g' | sed 's/?/:alphabet-yellow-question:/' | sed 's/!/:alphabet-yellow-exclamation:/g' | sed 's/yellow/white/g'
}


# +------------------+
# | AUTO-SUGGESTIONS |
# +------------------+

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#008080,underline"
# CTRL + ENTER to accept suggestion
bindkey '^y' autosuggest-accept

# FUCK
eval $(thefuck --alias)



