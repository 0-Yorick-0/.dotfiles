local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local vpn = sbar.exec("scutil --nc list | grep Connected | sed -R 's/.*\"(.*)\".*/\\1/'")

local vpn_icon = sbar.add("item", "widgets.vpn.icon", {
	position = "right",
	icon = {
		padding_right = 0,
		font = {
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		string = icons.vpn,
	},
})

local vpn_label = sbar.add("item", "widgets.vpn.label", {
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

local vpn_bracket = sbar.add("bracket", "widgets.vpn.bracket", {
	vpn_icon.name,
	vpn_label.name,
}, {
	background = {
		color = colors.bg1,
		border_color = colors.grey,
		border_width = 1,
	},
})

sbar.add("item", "widgets.vpn.padding", {
	position = "right",
	width = settings.group_paddings,
})

sbar.add("event", "vpn_change", "com.apple.networkConnect")

vpn_label:subscribe("vpn_change", function()
	sbar.exec("scutil --nc list | grep Connected | sed -R 's/.*\"(.*)\".*/\\1/'", function(result)
		vpn_label:set({ label = result ~= "" and result or "None" })
	end)
end)
--
--
-- VPN=$(scutil --nc list | grep Connected | sed -R 's/.*"(.*)".*/\1/')
--
-- if [[ $VPN != "" ]]; then
-- 	sketchybar -m --set vpn icon= \
-- 		label="$VPN" \
-- 		drawing=on
-- else
-- 	sketchybar -m --set vpn drawing=off
-- fi
