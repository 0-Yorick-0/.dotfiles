local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

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
		string = icons.headphones,
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
		string = "??%",
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
})

sbar.add("item", "widgets.headphones.padding", {
	position = "right",
	width = settings.group_paddings,
})

-- add custom event to listen for bluetooth changes ("com.apple.bluetooth.status")
sbar.add("event", "bluetooth_change", "com.apple.bluetooth.status")

headphones_label:subscribe("bluetooth_change", function()
	-- update the label with the new devices and appropriate escape sequences
	sbar.exec(
		"system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]? | select( .[] | .device_minorType ) | keys[]'",
		function(result)
			headphones_label:set({ label = result ~= "" and result or "None" })
		end
	)
end)
