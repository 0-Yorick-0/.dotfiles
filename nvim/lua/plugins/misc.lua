return {
	"christoomey/vim-tmux-navigator",

	-- Close buffer without closing window
	"moll/vim-bbye",

	-- easily surround words with quotes, parenthesis and so on
	"tpope/vim-surround",
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	"ryanoasis/vim-devicons",
}
