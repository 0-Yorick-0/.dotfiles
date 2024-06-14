return {
	{
		-- set a different color per file type
		"folke/styler.nvim",
		event = "VeryLazy",
		config = function()
			require("styler").setup({
				themes = {
					markdown = { colorscheme = "gruvbox" },
					help = { colorscheme = "gruvbox" },
				},
			})
		end,
	},
	{ "diegoulloao/neofusion.nvim", priority = 1000, config = true },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 800,
		config = function()
			local tokyonight = require("tokyonight")
			tokyonight.setup({ style = "storm" })
			local themes = {
				"duskfox",
				"nordfox",
				"terafox",
				"nightfox",
				"catppuccin",
				"kanagawa",
				"rose-pine",
				"tokyonight",
				"onedark",
			}

			-- needed to go around a well known problem of static number of math.random in lua
			math.randomseed(os.time())
			local randomIndex = math.random(1, #themes)
			vim.cmd.colorscheme(themes[randomIndex])
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup()
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = vim.g.transparent_enabled,
			})
		end,
	},
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
	},
	{
		"ribru17/bamboo.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup()
		end,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup()
		end,
	},
}
