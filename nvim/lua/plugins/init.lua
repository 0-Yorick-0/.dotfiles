return {
	"christoomey/vim-tmux-navigator",

	-- Close buffer without closing window
	"moll/vim-bbye",

	-- Restore previous session
	-- "rmagatti/auto-session",
	"lewis6991/impatient.nvim",
	-- Undo history manager
	"mbbill/undotree",

	-- Git integration

	"tpope/vim-fugitive",
	"airblade/vim-gitgutter",
	{
		"f-person/git-blame.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>")
		end,
	},
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

	-- easily surround words with quotes, parenthesis and so on
	"tpope/vim-surround",

	-- auto close parenthesis
	"windwp/nvim-autopairs",

	-- Make comments the easy way
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	"jose-elias-alvarez/null-ls.nvim",

	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- show shortcuts
	{
		"folke/which-key.nvim",
		config = function()
			-- vim.o.timeout = true
			-- vim.o.timeoutlen = 50
			require("which-key").setup({})
		end,
	},
	"folke/neodev.nvim",
	-- need both to finally have devicons in tree
	"ryanoasis/vim-devicons",
	{ "kyazdani42/nvim-web-devicons", lazy = true },
}
