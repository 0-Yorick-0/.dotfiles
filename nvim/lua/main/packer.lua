local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('packer_user_config', { clear = true }),
    pattern = "packer.lua",
    command = "source <afile> | PackerSync"
})

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { 'nvim-lua/plenary.nvim' }
        }
    }
    -- Theme
    use 'sainnhe/sonokai'

    -- To parse & higlight codebase
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- To work only on a small list of files
    use 'theprimeagen/harpoon'

    -- Close buffer without closing window
    use 'moll/vim-bbye'

    -- Restore previous session
    use 'rmagatti/auto-session'

    -- Undo history manager
    use 'mbbill/undotree'

    -- Git integration
    use {
        'tpope/vim-fugitive',
        'airblade/vim-gitgutter',
        { "f-person/git-blame.nvim", config = function() vim.keymap.set("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>") end },
        { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
    }
    -- autompletion with lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    -- easily surround words with quotes, parenthesis and so on
    use 'tpope/vim-surround'

    -- Make comments the easy way
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        "phpactor/phpactor",
        ft = { "php" },
        branch = "master",
        run = "composer install --no-dev -o"
    }

    -- use 'phpactor/behat-extension'

    use('jose-elias-alvarez/null-ls.nvim')

    -- Debugger
    use {
        "mfussenegger/nvim-dap",
        opt = true,
        event = "BufReadPre",
        module = { "dap" },
        wants = { "nvim-dap-virtual-text", "nvim-dap-ui" },
        requires = {
            "theHamsta/nvim-dap-virtual-text",
            -- create a beautiful debugger UI
            "rcarriga/nvim-dap-ui",
            "nvim-telescope/telescope-dap.nvim",
            { "leoluz/nvim-dap-go", module = "dap-go" },
            { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
        config = function()
            require("main.dap").setup()
        end,
    }

    -- Set lualine as statusline
    -- See `:help lualine.txt`
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --Enhance Netrw Experience
    use 'tpope/vim-vinegar'


    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use 'ryanoasis/vim-devicons'

    if is_bootstrap then
        require('packer').sync()
    end
end)
