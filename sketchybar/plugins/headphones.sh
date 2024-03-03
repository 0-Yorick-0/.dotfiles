#!/usr/bin/env bash

DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]? | select( .[] | .device_minorType == "Headset") | keys[]')"

if [ "$DEVICES" = "" ]; then
	sketchybar --set $NAME drawing=off background.padding_right=0 background.padding_left=0 label=""
else
	sketchybar --set $NAME drawing=on background.padding_right=2 background.padding_left=4 label="$DEVICES"
fi
