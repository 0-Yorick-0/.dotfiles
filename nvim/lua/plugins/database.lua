-- Database
return {
	"tpope/vim-dadbod",
	dependencies = {
		"kristijanhusak/vim-dadbod-ui",
		"kristijanhusak/vim-dadbod-completion",
	},
	config = function()
		local function db_completion()
			require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		end
		-- :echo g:db_ui_save_location to show config files
		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"mysql",
				"plsql",
			},
			callback = function()
				vim.schedule(db_completion)
			end,
		})
		local wk = require("which-key")
		wk.add({
			{ "<leader>D", group = "Database" },
			{ "<leader>Du", "<Cmd>DBUIToggle<Cr>", desc = "Toggle UI" },
			{ "<leader>Df", "<Cmd>DBUIFindBuffer<Cr>", desc = "Find buffer" },
			{ "<leader>Dr", "<Cmd>DBUIRenameBuffer<Cr>", desc = "Rename buffer" },
			{ "<leader>Dq", "<Cmd>DBUILastQueryInfo<Cr>", desc = "Last query info" },
		})
	end,
}
