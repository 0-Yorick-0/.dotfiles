return {
    {
        -- set a different color per file type
        "folke/styler.nvim",
        event = "VeryLazy",
        config = function()
            require("styler").setup {
                themes = {
                    markdown = { colorscheme = "gruvbox" },
                    help = { colorscheme = "gruvbox" },
                },
            }
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 800,
        config = function()
            local tokyonight = require "tokyonight"
            tokyonight.setup { style = "storm" }
            local themes = {
                "carbonfox",
                "duskfox",
                "nordfox",
                "terafox",
                "nightfox",
                "catppuccin",
                "kanagawa",
                "oxocarbon",
                "rose-pine",
                "tokyonight",
                -- "bamboo",
                "everforest",
                "onedark",
            }

            -- needed to go around a well known problem of static number of math.random in lua
            math.randomseed(os.time())
            local randomIndex = math.random(1, #themes)
            print(randomIndex)
            vim.cmd.colorscheme(themes[randomIndex])
        end,
    },
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup()
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup()
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup()
        end,
    },
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
    },
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup()
        end,
    },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup()
        end,
    },
}
