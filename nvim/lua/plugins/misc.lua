return {
	"christoomey/vim-tmux-navigator",

	-- Close buffer without closing window
	"moll/vim-bbye",

	-- easily surround words with quotes, parenthesis and so on
	"tpope/vim-surround",

	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	"folke/neodev.nvim",
	-- need both to finally have devicons in tree
	"ryanoasis/vim-devicons",
	--{ "kyazdani42/nvim-web-devicons", lazy = true },
}
