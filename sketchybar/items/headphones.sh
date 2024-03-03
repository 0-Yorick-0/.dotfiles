#!/bin/bash

sketchybar -m --add event bluetooth_change "com.apple.bluetooth.status" \
	\
	--add item headphones right \
	--set headphones icon= \
	script="~/.config/sketchybar/plugins/headphones.sh" \
	--subscribe headphones bluetooth_change
