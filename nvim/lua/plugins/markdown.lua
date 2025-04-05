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
		opts = {},
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
