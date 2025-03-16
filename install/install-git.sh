#!/bin/sh

brew install lazygit 

 ln -sf "$DOTFILES/git/.gitignore_global" "$HOME"

 if [ -f "$HOME/.gitignore" ]; then
 	echo "[core]" >>> "$HOME/.gitignore"
 	echo "excludesfile = /Users/yferlin/.gitignore_global" >>> "$HOME/.gitignore"
fi
