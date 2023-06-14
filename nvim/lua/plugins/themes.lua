return {
    "nyoom-engineering/oxocarbon.nvim",
    dependencies = {
        "EdenEast/nightfox.nvim",
        "rebelot/kanagawa.nvim",
        "rose-pine/neovim",
        "folke/tokyonight.nvim",
        "catppuccin/nvim",
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
        }

        local randomIndex = math.random(1, #themes)
        vim.cmd.colorscheme(themes[randomIndex])
    end,
}
