return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		defaults = {},
		---@type false | "classic" | "modern" | "helix"
		preset = vim.g.which_key_preset or "helix", -- default is "classic"
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>q", group = "Quickfix" },
				{ "<leader>g", group = "Git" },
				{ "<leader>f", group = "Telescope" },
				{ "<leader>u", group = "UI" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
