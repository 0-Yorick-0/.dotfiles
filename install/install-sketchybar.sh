#!/bin/sh

if [ ! -d "$XDG_CONFIG_HOME/sketchybar" ]; then
	mkdir "$XDG_CONFIG_HOME/sketchybar"
fi

# skeytchybar font
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

ln -sf "$DOTFILES/sketchybar" "$XDG_CONFIG_HOME/sketchybar"
chmod +x "$XDG_CONFIG_HOME/sketchybar/colors.sh"
chmod +x "$XDG_CONFIG_HOME/sketchybar/plugins/icon_map_fn.sh"
chmod +x "$XDG_CONFIG_HOME/sketchybar/plugins/space_windows.sh"
