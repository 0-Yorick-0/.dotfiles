-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.color_scheme = "nord"
-- config.color_scheme = "Nord (base16)"
-- config.color_scheme = "nordfox"
-- config.color_scheme = "Nova (base16)"
-- config.color_scheme = "Material (terminal.sexy)"
-- config.color_scheme = "Material Palenight (base16)"
-- config.color_scheme = "Monokai (dark) (terminal.sexy)"

-- This is where you actually apply your config choices

-- my coolnight colorscheme
-- see https://www.hover.dev/css-color-palette-generator
-- or https://tinter.hoolite.be/
config.colors = {
	foreground = "#B49A81",
	background = "#050505",
	cursor_bg = "#2b676b",
	cursor_border = "#973D19",
	cursor_fg = "#011423",
	selection_bg = "#2b676b",
	selection_fg = "#CBE0F0",
	ansi = { "#B43302", "#AF5563", "#FDD841", "#B47808", "#E6E6E6", "#08B422", "#E6E6E6", "#E6E6E6" },
	brights = { "#858585", "#AF5563", "#FDD841", "#B47808", "#FDD841", "#08B422", "#089AB4", "#E6E6E6" },
}

config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 19

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config
