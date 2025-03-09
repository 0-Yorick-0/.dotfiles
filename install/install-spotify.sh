#!/usr/bin/env bash

# +---------+
# | Spotify |
# +---------+

# CLI client for the GUI of Spotify
# see https://medium.com/@baruchphillips/using-spotify-in-cli-e7d946c27b3e to configure it
brew install shpotify
# Spotify light client
brew install spotifyd
# Spotify client for the terminal
# see https://github.com/Rigellute/spotify-tui for install
brew install spotify_player
if [ ! -d "$XDG_CONFIG_HOME/spotifyd" ]; then
	mkdir "$XDG_CONFIG_HOME/spotifyd"
fi

rustup update
cargo install spotify_player --features lyric-finder
cargo install spotify_player --features image

ln -sf "$DOTFILES/spotify/spotifyd.conf" "$XDG_CONFIG_HOME/spotifyd/spotifyd.conf"
ln -sf "$DOTFILES/spotify/theme.toml" "$XDG_CONFIG_HOME/spotify-player/theme.toml"
