return {
    "nyoom-engineering/oxocarbon.nvim",
    dependencies = {
        "EdenEast/nightfox.nvim",
        "rebelot/kanagawa.nvim",
        "rose-pine/neovim",
        "folke/tokyonight.nvim",
        "catppuccin/nvim",
        "ribru17/bamboo.nvim",
        "sainnhe/everforest",
        "navarasu/onedark.nvim",
    },
    config = function()
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
            "bamboo",
            "everforest",
            "onedark",
        }

        local randomIndex = math.random(1, #themes)
        vim.cmd.colorscheme(themes[randomIndex])
    end,
}
