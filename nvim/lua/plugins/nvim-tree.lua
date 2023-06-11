return {
	{
		"nvim-tree/nvim-tree.lua",
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			-- disable netrw at the very start of your init.lua (strongly advised)
			-- vim.g.loaded_netrw = 1
			-- vim.g.loaded_netrwPlugin = 1
			vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<cr>")
			-- Reveal file in tree
			vim.keymap.set("n", "<leader>-", ":NvimTreeFindFileToggle<cr>")
			-- set termguicolors to enable highlight groups
			vim.opt.termguicolors = true

			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
			})
		end,
	},
}