#!/bin/bash

WIFI_CONNECTED=􀙇
WIFI_DISCONNECTED=􀙈

wifi=(
	padding_right=7
	label.width=0
	icon.padding_right=6
	icon.padding_left=6
	icon="$WIFI_DISCONNECTED"
	script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
	--set wifi "${wifi[@]}" \
	--subscribe wifi wifi_change mouse.clicked
