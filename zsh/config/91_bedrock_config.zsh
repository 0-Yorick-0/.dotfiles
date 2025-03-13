#!/usr/bin//env zsh

ln -sf $DOTFILES/zsh/config/xdebug.zsh $HOME/.local/bin/xdebug.conf

# source $HOME/bin/switch.sh


export PATH=/Users/yorick.ferlin/.local/bin:$PATH
source /Users/yorick.ferlin/.local/bin/switch.sh
source /Users/yorick.ferlin/.config/bedrock-cli/aliases_zsh
source /Users/yorick.ferlin/.config/bedrock-cli/completion_zsh


# export KUBECONFIG="$HOME/.kube/static-kubeconfigs"
# export KUBECONFIG=$KUBECONFIG/6cloud.config:$KUBECONFIG/sandbox.config:$KUBECONFIG/m6.config:$KUBECONFIG/services.config:$KUBECONFIG/videoland.config:$KUBECONFIG/rtlde.config
# export KUBECONFIG="$HOME/.kube/6cloud.config:$HOME/.kube/videoland.config:$HOME/.kube/rtlde.config:$HOME/.kube/services.config:$HOME/.kube/sandbox.config"
[[ $+commands[aws] ]] && complete -C '/usr/bin/aws_completer' aws
