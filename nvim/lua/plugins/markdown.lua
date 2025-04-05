return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		main = "render-markdown",
		ft = { "markdown" },
		opts = {
			html = {
				-- Turn on / off all HTML rendering
				enabled = true,
				comment = {
					-- Turn on / off HTML comment concealing
					conceal = false,
				},
			},
			bullet = {
				enabled = true,
				render_modes = false,
				icons = { "●", "○", "◆", "◇" },
				ordered_icons = function(ctx)
					local value = vim.trim(ctx.value)
					local index = tonumber(value:sub(1, #value - 1))
					return string.format("%d.", index > 1 and index or ctx.index)
				end,
				left_pad = 0,
				right_pad = 0,
				highlight = "RenderMarkdownBullet",
				scope_highlight = {},
			},
			checkbox = {
				-- Turn on / off checkbox state rendering.
				enabled = true,
				-- Additional modes to render checkboxes.
				render_modes = false,
				-- Padding to add to the right of checkboxes.
				right_pad = 1,
				unchecked = {
					-- Replaces '[ ]' of 'task_list_marker_unchecked'.
					icon = "󰄱 ",
					-- Highlight for the unchecked icon.
					highlight = "RenderMarkdownUnchecked",
					-- Highlight for item associated with unchecked checkbox.
					scope_highlight = nil,
				},
				checked = {
					-- Replaces '[x]' of 'task_list_marker_checked'.
					icon = "󰱒 ",
					-- Highlight for the checked icon.
					highlight = "RenderMarkdownChecked",
					-- Highlight for item associated with checked checkbox.
					scope_highlight = nil,
				},
			},
			heading = {
				sign = false,
				icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
				backgrounds = {
					"Headline1Bg",
					"Headline2Bg",
					"Headline3Bg",
					"Headline4Bg",
					"Headline5Bg",
					"Headline6Bg",
				},
				foregrounds = {
					"Headline1Fg",
					"Headline2Fg",
					"Headline3Fg",
					"Headline4Fg",
					"Headline5Fg",
					"Headline6Fg",
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
		end,
	},
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		keys = {
			{
				"<leader>mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
