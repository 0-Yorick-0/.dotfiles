return {
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
	},
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				presets = {
					long_message_to_split = true, -- long messages will be sent to a split
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = false,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				messages = {
					enabled = true,
				},
				views = {
					cmdline_input = {
						win_options = {
							wrap = true,
							linebreak = true,
						},
					},
					confirm = {
						win_options = {
							wrap = true,
							linebreak = true,
						},
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
