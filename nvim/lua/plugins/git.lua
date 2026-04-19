-- Git integration
return {
	{
		-- use :LazyGitConfig on first time to create config file
		"kdheepak/lazygit.nvim",
		lazy = false,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gb", "<Cmd>Gitsigns blame<CR>")
			vim.keymap.set("n", "<leader>gbt", "<Cmd>Gitsigns toggle_current_line_blame<CR>")
			require("gitsigns").setup({
				current_line_blame = true,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = {
			{ "<leader>gdo", "<Cmd>DiffviewOpen<Cr>", desc = "[G]it [D]iffview[O]pen" },
			{ "<leader>gdc", "<Cmd>DiffviewClose<Cr>", desc = "[G]it [D]iffview[C]lose" },
			{ "<leader>gdt", "<Cmd>DiffviewToggleFiles<Cr>", desc = "[G]it [D]iffview[T]oggleFiles" },
			{ "<leader>gdf", "<Cmd>DiffviewFocusFiles<Cr>", desc = "[G]it [D]iffview[F]ocusFiles" },
			{ "<leader>gdh", "<Cmd>DiffviewFileHistory<Cr>", desc = "[G]it [D]iffviewFile[H]istory" },
		},
	},
}
