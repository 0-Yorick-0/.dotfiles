local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local vpn = sbar.exec("scutil --nc list | grep Connected | sed -R 's/.*\"(.*)\".*/\\1/'")

if vpn == "" then
	vpn = nil
end

if vpn then
	local vpn = sbar.add("item", "widgets.vpn", {
		position = "right",
		icon = {
			padding_right = 0,
			font = {
				style = settings.font.style_map["Bold"],
				size = 9.0,
			},
			string = icons.vpn.connected,
		},
		label = {
			font = {
				family = settings.font.numbers,
				style = settings.font.style_map["Bold"],
				size = 9.0,
			},
			color = colors.white,
			string = vpn,
		},
	})

	local vpn_bracket = sbar.add("bracket", "widgets.vpn.bracket", {
		vpn.name,
	}, {
		background = {
			color = colors.bg1,
			border_color = colors.grey,
			border_width = 1,
		},
		popup = { align = "center" },
	})
end

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
