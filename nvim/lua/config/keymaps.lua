local M = {}
local map = vim.keymap.set
vim.g.mapleader = " "

-- BUFFERS--
map("n", "<leader>bd", ":bd<cr>")
-- close buffer without closing window
map("n", "<leader>q", ":Bdelete<CR>")
-- close all buffers
map("n", "<leader>qa!", ":bufdo :Bdelete<CR>")
-- close all hidden buffers
map("n", "<leader>Q", ":Survivor<CR>", { desc = "close all hidden buffers" })
-- force alternate file
map("n", "<C-^>", ":e #<CR>", { desc = "force alternate file" })

-- open a tab with a note file
map("n", "<leader>n", ":tab drop tmp/notes.md<CR>", { desc = "open [n]otes file" })

-- LINES --
-- move up or down selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-2<CR>gv=gv")

-- keep cursor in middle of viewport while navigating
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- keep cursor in middle of viewport while in search result navigating
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- line highlighting
vim.api.nvim_set_hl(0, "LineHighLight", { bg = "#83a598", fg = "#3c3836" })
map("n", "<leader>ll", function()
	vim.fn.call("matchadd", { "LineHighLight", "\\%" .. vim.fn.line(".") .. "l" })
end, { silent = true }, { desc = "high[l]ight current [l]ine" })
map("n", "<leader>c", function()
	vim.fn.call("clearmatches", {})
end, { desc = "[C]lear all highlights" })

map("n", "<leader>h", ":noh<CR>", { desc = "clear [h]ighlight" })

-- keep the current paste buffer on copy
map("x", "<leader>p", '"_dp')
map("x", "<leader>p", '"_dp')
-- same for deleting
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- separating paste buffer
map("n", "<leader>y", '"+y', { desc = "copy to clipboard" })
map("v", "<leader>y", '"+y', { desc = "copy to clipboard" })
-- copy on main paste buffer
map("n", "<leader>Y", '"+Y', { desc = "copy to main paste buffer" })

-- tools for quickfix list
map("n", "<C-n>", "<cmd>cnext<CR>zz", { desc = "next element in quickfix list" })
map("n", "<C-p>", "<cmd>cprev<CR>zz", { desc = "previous element in quickfix list" })
map("n", "<leader>qk", "<cmd>lnext<CR>zz", { desc = "next quickfix" })
map("n", "<leader>ql", "<cmd>lprev>zz", { desc = "previous quickfix" })

-- open a regex to replace current word
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace thi[s] word" })
-- make current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "make e[x]ecutable", silent = true })

-- format file with current language good practices
map("n", "<leader>f", vim.lsp.buf.format)

M.tmux_pane_function = function(dir)
	-- NOTE: variable that controls the auto-cd behavior
	local auto_cd_to_new_dir = true
	-- NOTE: Variable to control pane direction: 'right' or 'bottom'
	-- If you modify this, make sure to also modify TMUX_PANE_DIRECTION in the
	-- zsh-vi-mode section on the .zshrc file
	-- Also modify this in your tmux.conf file if you want it to work when in tmux
	-- copy-mode
	local pane_direction = vim.g.tmux_pane_direction or "bottom"
	-- NOTE: Below, the first number is the size of the pane if split horizontally,
	-- the 2nd number is the size of the pane if split vertically
	local pane_size = (pane_direction == "right") and 60 or 15
	local move_key = (pane_direction == "right") and "C-l" or "C-k"
	local split_cmd = (pane_direction == "right") and "-h" or "-v"
	-- if no dir is passed, use the current file's directory
	local file_dir = dir or vim.fn.expand("%:p:h")
	-- Simplified this, was checking if a pane existed
	local has_panes = vim.fn.system("tmux list-panes | wc -l"):gsub("%s+", "") ~= "1"
	-- Check if the current pane is zoomed (maximized)
	local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"
	-- Escape the directory path for shell
	local escaped_dir = file_dir:gsub("'", "'\\''")
	-- If any additional pane exists
	if has_panes then
		if is_zoomed then
			-- Compare the stored pane directory with the current file directory
			if auto_cd_to_new_dir and vim.g.tmux_pane_dir ~= escaped_dir then
				-- If different, cd into the new dir
				vim.fn.system("tmux send-keys -t :.+ 'cd \"" .. escaped_dir .. "\"' Enter")
				-- Update the stored directory to the new one
				vim.g.tmux_pane_dir = escaped_dir
			end
			-- If zoomed, unzoom and switch to the correct pane
			vim.fn.system("tmux resize-pane -Z")
			vim.fn.system("tmux send-keys " .. move_key)
		else
			-- If not zoomed, zoom current pane
			vim.fn.system("tmux resize-pane -Z")
		end
	else
		-- Store the initial directory in a Neovim variable
		if vim.g.tmux_pane_dir == nil then
			vim.g.tmux_pane_dir = escaped_dir
		end
		-- If no pane exists, open it with zsh and DISABLE_PULL variable
		vim.fn.system(
			"tmux split-window "
				.. split_cmd
				.. " -l "
				.. pane_size
				.. " 'cd \""
				.. escaped_dir
				.. "\" && DISABLE_PULL=1 zsh'"
		)
		vim.fn.system("tmux send-keys " .. move_key)
		-- Resolve zsh-vi-mode issue for first-time pane
		vim.fn.system("tmux send-keys Escape i")
	end
end
-- If I execute the function without an argument, it will open the dir where the
-- current file lives
vim.keymap.set({ "n", "v", "i" }, "<M-t>", function()
	M.tmux_pane_function()
end, { desc = "[P]Terminal on tmux pane" })

return M
