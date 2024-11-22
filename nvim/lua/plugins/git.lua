-- Git integration
return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
	"airblade/vim-gitgutter",
	{
		"f-person/git-blame.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>")
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
	{
		"TimUntersberger/neogit",
		cmd = "Neogit",
		opts = {
			integrations = { diffview = true },
		},
		keys = {
			{ "<leader>gs", "<cmd>Neogit kind=floating<cr>", desc = "[S]tatus" },
		},
	},
}
