local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true
    PACKER_BOOTSTRAP = print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
    pattern = "packer.lua",
    command = "source <afile> | PackerSync",
})

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("christoomey/vim-tmux-navigator")

    ------------------------
    ------- Appearance------
    ------------------------
    use({
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        requires = { "nvim-tree/nvim-web-devicons" },
    })

    -- Theme
    use("sainnhe/sonokai")

    -- Set lualine as statusline
    -- See `:help lualine.txt`
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    ------------------
    ------- PHP ------
    ------------------
    use({
        "phpactor/phpactor",
        ft = { "php" },
        branch = "master",
        run = "composer install --no-dev -o",
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
    })

    -- To parse & higlight codebase
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    -- Close buffer without closing window
    use("moll/vim-bbye")

    -- Restore previous session
    -- use("rmagatti/auto-session")
    use("lewis6991/impatient.nvim")
    -- Undo history manager
    use("mbbill/undotree")

    -- Git integration
    use({
        "tpope/vim-fugitive",
        "airblade/vim-gitgutter",
        {
            "f-person/git-blame.nvim",
            config = function()
                vim.keymap.set("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>")
            end,
        },
        { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
    })
    -- autompletion with lsp
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    })

    -- easily surround words with quotes, parenthesis and so on
    use("tpope/vim-surround")

    -- auto close parenthesis
    use("windwp/nvim-autopairs")

    -- Make comments the easy way
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use("jose-elias-alvarez/null-ls.nvim")

    -- Debugger
    use({
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
            { "leoluz/nvim-dap-go",                module = "dap-go" },
            { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
        config = function()
            require("main.dap").setup()
        end,
    })

    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })

    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    -- show shortcuts
    use({
        "folke/which-key.nvim",
        require("which-key").setup(),
    })

    -- need both to finally have devicons in tree
    use("ryanoasis/vim-devicons")
    use("kyazdani42/nvim-web-devicons")

    if is_bootstrap then
        require("packer").sync()
    end
end)
