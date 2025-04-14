# Setup fzf
# ---------
if [[ ! "$PATH" == *$DOTFILES/zsh/plugins/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$DOTFILES/zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$DOTFILES/zsh/plugins/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$DOTFILES/zsh/plugins/fzf/shell/key-bindings.zsh"

## necessary to not being in conflict with vi command mode
## see https://github.com/junegunn/fzf-git.sh/issues/23
bindkey -r '^G'  
# Fzf-git
source "$DOTFILES/zsh/plugins/fzf-git.sh/fzf-git.sh"


export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "
