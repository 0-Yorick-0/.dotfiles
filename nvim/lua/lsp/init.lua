-- autompletion with lsp
return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = false,
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },                                       -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            { "simrat39/rust-tools.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },         -- Required
            { "hrsh7th/cmp-nvim-lsp" },     -- Required
            { "hrsh7th/cmp-buffer" },       -- Optional
            { "hrsh7th/cmp-path" },         -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" },     -- Optional
            { "honza/vim-snippets" },
            -- LSP
            { "towolf/vim-helm" },

            -- Snippets
            {
                "L3MON4D3/LuaSnip", -- Required
                -- load snippets. See https://github.com/honza/vim-snippets/blob/master/snippets/php.snippets
                -- for list of snippets shortcuts
                config = function()
                    -- required to enable snippets from honza/vim-snippets
                    require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading
                end,
                build = "make install_jsregexp",
            },
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
        config = function()
            -- Learn the keybindings, see :help lsp-zero-keybindings
            -- Learn to configure LSP servers, see :help lsp-zero-api-showcase
            local lsp = require("lsp-zero").preset({ "recommended" })

            lsp.ensure_installed({
                "tsserver",
                "intelephense",
                "vimls",
                "eslint",
                "lua_ls",
                "dockerls",
                "sqlls",
                "marksman",
                "gopls",
                "jsonls",
                "phpactor",
                "rust_analyzer",
                "helm_ls",
            })

            lsp.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["lua_ls"] = { "lua" },
                    ["rust_analyzer"] = { "rust" },
                    ["gopls"] = { "go" },
                    ["intelephense"] = { "php" },
                    ["helm_ls"] = { "helm" },
                },
            })

            -- Fix undefined global 'vim'
            lsp.nvim_workspace()
            --
            -- base config

            lsp.on_attach(require('lsp.keymaps'))

            -- then for each specific language, we overload the config
            local lspconfig = require("lspconfig")
            lspconfig.phpactor.setup({
                init_options = {
                    ["language_server_phpstan.enabled"] = false,
                    ["language_server_psalm.enabled"] = false,
                },
            })

            lspconfig.gopls.setup({
                cmd = { "gopls", "serve" },
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            lspconfig.intelephense.setup({})

            -- Helm
            if not lspconfig.helm_ls then
                lspconfig.helm_ls = {
                    default_config = {
                        cmd = { "helm_ls", "serve" },
                        filetypes = { 'helm' },
                        root_dir = function(fname)
                            return util.root_pattern('Chart.yaml')(fname)
                        end,
                    },
                }
            end

            lspconfig.helm_ls.setup {
                filetypes = { "helm" },
                cmd = { "helm_ls", "serve" },
            }

            lsp.setup()
            local cmp = require("lsp.cmp")
            cmp.setup()
        end,
    },
    -- inlay hints
    {
        "simrat39/inlay-hints.nvim",
        config = function()
            require("inlay-hints").setup({
                only_current_line = false,
                eol = {
                    right_align = false,
                },
            })
        end,
    },
    {
        {
            "mhanberg/output-panel.nvim",
            event = "VeryLazy",
            config = function()
                require("output_panel").setup()
            end,
        },
    },
}
