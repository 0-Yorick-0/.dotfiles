#!/bin/bash

sketchybar -m --add item vpn right \
	--set vpn icon= \
	label.width=0 \
	icon.padding_right=8 \
	update_freq=5 \
	script="~/.config/sketchybar/plugins/vpn.sh"
