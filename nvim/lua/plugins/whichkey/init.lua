return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require "which-key"
        wk.setup {
            show_help = false,
            plugins = { spelling = true },
            key_labels = { ["<leader>"] = "SPC" },
            triggers = "auto",
        }
        wk.register(require('plugins.whichkey.mapping'), { prefix = "<leader>" })
    end,
}
