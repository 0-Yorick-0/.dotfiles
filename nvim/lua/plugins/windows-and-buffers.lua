return {
	{
		"nvim-focus/focus.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>m=", ":FocusMaxOrEqual<CR>", { silent = true })
			vim.keymap.set("n", "<leader>mx", ":FocusMaximise<CR>", { silent = true })
			require("focus").setup()
		end,
	},
}
