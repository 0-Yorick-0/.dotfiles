#!/usr/bin/env bash

brew install mycli

# XDG_CONFIG_HOME doesn't seem to be supported...
ln -sf $DOTFILES/mycli/myclirc $HOME/.myclirc
