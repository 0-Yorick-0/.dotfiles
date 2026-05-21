#!/usr/bin//env zsh

fpath=($DOTFILES/zsh/plugins $fpath)

# +--------------+
# | CONFIG FILES |
# +--------------+
# typeset -ga sources

# Get personnal config file
sources=($DOTFILES/zsh/config/*.zsh)

# needed because the script is launched outside of a Terminal
# so it doesn't has access to stuff in ~/.profile
gdate=/opt/homebrew/bin/gdate
if [ ! -x $gdate ]; then
	gdate=/usr/local/bin/gdate
fi
if [ ! -x $gdate ]; then
	echo "FATAL ERROR: $gdate not found." >&2
	exit 1
fi

# try to include all sources
foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        sourceIncludeTimeStart=$($gdate +%s%N)
        source $file
        sourceIncludeDuration=$((($($gdate +%s%N) - $sourceIncludeTimeStart)/1000000))
        echo $sourceIncludeDuration ms runtime for $file
    fi
end


#launch tmux at startup
if [ -z "$TMUX" ]; then tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf; fi

#loading ssh-key to keychain
eval $(keychain --eval --quiet id_rsa ~/.ssh/id_*)

# +--------+
# | PROMPT |
# +--------+

# Load igloo prompt config
# source $DOTFILES/zsh/themes/git-prompt.sh
# source $DOTFILES/zsh/themes/igloo.zsh

# +---------+
# | ALIASES |
# +---------+

source $DOTFILES/aliases/aliases

# +------------+
# | COMPLETION |
# +------------+

source $DOTFILES/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh

autoload bashcompinit && bashcompinit
# Load completion system
autoload -Uz compinit
# initialize completion with cached metadata file
if [[ ! "$XDG_CONFIG_HOME/zsh" ]]; then
    mkdir -p "XDG_CACHE_HOME/zsh/zcompdump"
fi
compinit -d "XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Exemple : "doc" can complete to "Document"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

_comp_options+=(globdots) # With hidden files

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# +----------+
# | STARSHIP |
# +----------+
eval "$(starship init zsh)"

# +--------+
# | ZOXIDE |
# +--------+
eval "$(zoxide init zsh)"
