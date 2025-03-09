#!/usr/bin/env zsh

# Chemin vers votre clé privée SSH
ssh_key="$HOME/.ssh/id_ed25519"

# Vérifie si l'agent SSH est en cours d'exécution, sinon lancez-le
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
	ssh-agent -s | grep -v 'echo' >"$HOME/.ssh/ssh-agent-info"
fi

# Charger la clé SSH
ssh-add "$ssh_key"
