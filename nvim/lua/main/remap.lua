vim.g.mapleader = " "

-- BUFFERS--
vim.keymap.set("n", "<TAB>", ":bn<cr>")
vim.keymap.set("n", "<leader>bd", ":bd<cr>")
-- close buffer without closing window
vim.keymap.set("n", "<leader>q", ":Bdelete<CR>")
-- close all buffers
vim.keymap.set("n", "<leader>qa!", ":bufdo :Bdelete<CR>")
-- close all hidden buffers
vim.keymap.set("n", "<leader>Q", ":Survivor<CR>")

-- open a tab with a note file
vim.keymap.set("n", "<leader>n", ":tab drop tmp/notes.md<CR>")

-- LINES --
-- move up or down selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- takes the line below and append to the current
vim.keymap.set("n", "J", "mzJ`z")
-- keep cursor in middle of viewport while navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- keep cursor in middle of viewport while in search result navigating
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- line highlighting
vim.api.nvim_set_hl(0, "LineHighLight", { bg = "#83a598", fg = "#3c3836" })
vim.keymap.set("n", "<leader>ll", function()
	vim.fn.call("matchadd", { "LineHighLight", "\\%" .. vim.fn.line(".") .. "l" })
end, { silent = true })
vim.keymap.set("n", "<leader>c", function()
	vim.fn.call("clearmatches", {})
end)

-- keep the current paste buffer on copy
vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set("x", "<leader>p", '"_dp')
-- same for deleting
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- separating paste buffer
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
-- copy on main paste buffer
vim.keymap.set("n", "<leader>Y", '"+Y')

-- tools for quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>l", "<cmd>lprev>zz")

-- open a regex to replace current word
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- format file with current language good practices
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
