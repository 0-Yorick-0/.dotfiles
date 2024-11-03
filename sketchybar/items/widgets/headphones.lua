local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local devices = sbar.exec(
	"system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]? | select( .[] | .device_minorType == \"Headset\") | keys[]'"
)

local headphones_icon = sbar.add("item", "widgets.headphones.icon", {
	position = "right",
	icon = {
		padding_right = 0,
		align = "left",
		color = colors.grey,
		font = {
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		string = "test",
	},
})

local headphones_label = sbar.add("item", "widgets.headphones.label", {
	position = "right",
	update_freq = 180,
	label = {
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		color = colors.white,
		string = "None",
	},
})

local headphones_bracket = sbar.add("bracket", "widgets.headphones.bracket", {
	headphones_icon.name,
	headphones_label.name,
}, {
	background = {
		color = colors.bg1,
		border_color = colors.grey,
		border_width = 1,
	},
	popup = { align = "center" },
})

sbar.add("item", "widgets.headphones.padding", {
	position = "right",
	width = settings.group_paddings,
})

-- add custom event to listen for bluetooth changes ("com.apple.bluetooth.status")
headphones_label:subscribe("mouse.clicked", function()
	-- update the label with the new devices and appropriate escape sequences
	local device_connected = sbar.exec(
		"system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]?"
	)

	-- local devices = device_connected:find("keys[]") or "None"

	headphones_label:set({ label = device_connected })
end)
-- sketchybar -m --add event bluetooth_change "com.apple.bluetooth.status" \
-- 	\
-- 	--add item headphones right \
-- 	--set headphones icon= \
-- 	script="~/.config/sketchybar/plugins/headphones.sh" \
-- 	--subscribe headphones bluetooth_change
--
-- DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]? | select( .[] | .device_minorType == "Headset") | keys[]')"
--
-- if [ "$DEVICES" = "" ]; then
-- 	sketchybar --set $NAME drawing=off background.padding_right=0 background.padding_left=0 label=""
-- else
-- 	sketchybar --set $NAME drawing=on background.padding_right=2 background.padding_left=4 label="$DEVICES"
-- fi
