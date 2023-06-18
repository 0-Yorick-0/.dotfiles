return {
	"christoomey/vim-tmux-navigator",

	-- a game to be better at Vim
	"ThePrimeagen/vim-be-good",

	-- Close buffer without closing window
	"moll/vim-bbye",

	-- Restore previous session
	-- "rmagatti/auto-session",
	"lewis6991/impatient.nvim",

	-- easily surround words with quotes, parenthesis and so on
	"tpope/vim-surround",

	-- Make comments the easy way
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

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
	{ "kyazdani42/nvim-web-devicons", lazy = true },
}
