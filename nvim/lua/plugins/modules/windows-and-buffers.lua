return {
    {
        "nvim-focus/focus.nvim",
        dependencies = {
            "echasnovski/mini.test",
        },
        config = function()
            vim.keymap.set("n", "<leader>=", ":FocusMaxOrEqual<CR>", { silent = true })
            vim.keymap.set("n", "<leader>o", ":FocusMaximise<CR>", { silent = true })
            require("focus").setup()
        end,
    },
}
