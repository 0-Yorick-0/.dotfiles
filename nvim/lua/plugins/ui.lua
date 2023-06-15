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
	{
		-- Set lualine as statusline
		-- See `:help lualine.txt`
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "auto",
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
	{
		"HampusHauffman/block.nvim",
		config = function()
			require("block").setup({})
			vim.keymap.set("n", "<leader>b", ":Block<cr>")
		end,
	},
}
