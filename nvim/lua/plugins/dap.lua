-- Debugger
return {
    "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    event = "BufReadPre",
    module = { "dap" },
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        -- help to install debuggers
        "Pocco81/DAPInstall.nvim",
        -- create a beautiful debugger UI
        "rcarriga/nvim-dap-ui",
        -- which key integration
        {
            "folke/which-key.nvim",
            opts = {
                defaults = {
                    ["<leader>d"] = { name = "+debug" },
                    ["<leader>da"] = { name = "+adapters" },
                },
            },
        },
        "nvim-telescope/telescope-dap.nvim",
        { "leoluz/nvim-dap-go",                module = "dap-go" },
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
    config = function()
        require("main.dap").setup()
    end,
}
