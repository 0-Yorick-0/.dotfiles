return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	opts = {
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
	config = function()
		vim.keymap.set("n", "<leader>pv", ":NeoTree<cr>")
		-- Reveal file in tree
		vim.keymap.set("n", "<leader>-", ":Neotree filesystem reveal toggle left<cr>")
		require("neo-tree").setup({})
	end,
}
