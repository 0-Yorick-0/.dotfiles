return {
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
	},
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				messages = {
					enabled = false,
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- Theme
	-- "sainnhe/sonokai",
	{
		-- Theme inspired by Atom
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},

	-- Set lualine as statusline
	-- See `:help lualine.txt`
	"nvim-lualine/lualine.nvim",
}
