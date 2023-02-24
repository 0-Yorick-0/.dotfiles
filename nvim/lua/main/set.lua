vim.g.mapleader = " "

-- line numbers && relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.cursorline = true -- Enable highlighting of the current line

vim.opt.wrap = false

-- split in a more natural way
vim.opt.splitbelow = true
vim.opt.splitright = true

-- let undotree manage backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/$VIMCONFIG/undodir"
vim.opt.undofile = true

-- disable highlightsearch && enable incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- settings font for tree
vim.opt.guifont = "materialdesignicons-webfont:h21"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
