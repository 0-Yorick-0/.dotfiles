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
