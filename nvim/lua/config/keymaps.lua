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

map("n", "<leader>h", ":noh<CR>")

-- keep the current paste buffer on copy
map("x", "<leader>p", '"_dp')
map("x", "<leader>p", '"_dp')
-- same for deleting
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- separating paste buffer
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
-- copy on main paste buffer
map("n", "<leader>Y", '"+Y')

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
