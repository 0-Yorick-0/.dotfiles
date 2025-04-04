vim.g.mapleader = " "
vim.g.gofmt_command = "goimports"
vim.g.go_doc_balloon = 1
vim.g.go_doc_popup_window = 1
vim.g.markdown_folding = 1

-- enable true color support
vim.o.termguicolors = true

local set = vim.opt

-- line numbers && relative line numbers
set.nu = true
set.relativenumber = true

set.expandtab = true -- expand tab with spaces
set.tabstop = 4 -- set how many spaces are used for a indentation block
set.shiftwidth = 4 -- how many spaces are used when using `>>` operator
set.softtabstop = 4

set.smartindent = true
set.breakindent = true
set.cursorline = true -- Enable highlighting of the current line

-- When on, lines longer than the width of the window will wrap and displaying continues on the next line
set.wrap = false

-- split in a more natural way
set.splitbelow = true
set.splitright = true

-- let undotree manage backup
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/$VIMCONFIG/undodir"
set.undofile = true
set.undolevels = 10000 -- save 10000 undos max per file

-- disable highlightsearch && enable incremental search
set.incsearch = true

set.termguicolors = true

set.scrolloff = 8
set.signcolumn = "yes"
vim.diagnostic.config({
	--don't show those annoying virtual text messages from linters
	--use space + VD to see the full message
	virtual_text = false,
})
set.isfname:append("@-@")

set.updatetime = 50

set.colorcolumn = "80"

set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldmethod = "manual"

set.spell = true
set.spelllang = "en_us"

-- auto read file when changed outside of vim
set.autoread = true
