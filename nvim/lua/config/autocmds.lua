local function augroup(name)
	return vim.api.nvim_create_augroup("nde_" .. name, { clear = true })
end

-- Automatically create a backup of lazy-lock.json before updating
-- see https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp
local lazy_cmds = vim.api.nvim_create_augroup("lazy_cmds", { clear = true })
local snapshot_dir = vim.fn.stdpath("data") .. "/plugin-snapshot"
local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"

vim.api.nvim_create_user_command("BrowseSnapshots", "edit " .. snapshot_dir, {})

vim.api.nvim_create_autocmd("User", {
	group = lazy_cmds,
	pattern = "LazyUpdatePre",
	desc = "Backup lazy.nvim lockfile",
	callback = function(event)
		vim.fn.mkdir(snapshot_dir, "p")
		local snapshot = snapshot_dir .. os.date("/%Y-%m-%dT%H:%M:%S.json")

		vim.loop.fs_copyfile(lockfile, snapshot)
	end,
})

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = augroup("highlight_yank"),
	pattern = "*",
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- windows to close
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"OverseerForm",
		"OverseerList",
		"checkhealth",
		"floggraph",
		"fugitive",
		"git",
		"gitcommit",
		"help",
		"lspinfo",
		"man",
		"neotest-output",
		"neotest-summary",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"toggleterm",
		"tsplayground",
		"vim",
		"neoai-input",
		"neoai-output",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
