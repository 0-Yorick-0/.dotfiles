vim.g.mapleader = " "
vim.g.gofmt_command = "goimports"

local set = vim.opt

-- line numbers && relative line numbers
set.nu = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.smartindent = true
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

-- disable highlightsearch && enable incremental search
set.hlsearch = false
set.incsearch = true

set.termguicolors = true

set.scrolloff = 8
set.signcolumn = "yes"
set.isfname:append("@-@")

set.updatetime = 50

set.colorcolumn = "80"

set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldmethod = "manual"
