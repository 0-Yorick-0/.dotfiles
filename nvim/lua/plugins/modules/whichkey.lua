-- show shortcuts
return {
    {
        "folke/which-key.nvim",
        config = function()
            -- vim.o.timeout = true
            -- vim.o.timeoutlen = 50
            local which_key = require("which-key")
            which_key.setup({})
            which_key.register(require("main.whichkey"), {
                mode = "n",
                prefix = "<leader>",
            })
        end,
    },
}
