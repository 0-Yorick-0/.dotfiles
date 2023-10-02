#!/usr/bin//env zsh

fpath=($DOTFILES/zsh/plugins $fpath)

# +---------+
# | PLUGINS |
# +---------+
# take tike to measure boot time
#bootTimeStart=$(gdate +%s%N 2>/dev/null || date +%s%N)

typeset -ga sources

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
#bootTimeEnd=$(gdate +%s%N 2>/dev/null || date +%s%N)
#bootTimeDuration=$((($bootTimeEnd - $bootTimeStart)/1000000))
#echo $bootTimeDuration ms overall boot duration

#launch tmux at startup
if [ -z "$TMUX" ]; then tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf; fi

#loading ssh-key to keychain
eval $(keychain --eval --quiet id_rsa ~/.ssh/id_rsa)

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

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
source $DOTFILES/zsh/plugins/completion.zsh

# Command Completion
fpath=($DOTFILES/zsh/plugins/zsh-completions/src $fpath)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# +----------+
# | STARSHIP |
# +----------+
eval "$(starship init zsh)"
