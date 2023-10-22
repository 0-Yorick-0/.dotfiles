-- Debugger
return {
    "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    event = "BufReadPre",
    module = { "dap" },
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        -- create a beautiful debugger UI
        "rcarriga/nvim-dap-ui",
        -- help to install debuggers
        "Pocco81/DAPInstall.nvim",
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
    },
    opts = {},
    config = function(plugin, opts)
        require("base.dap.config").setup()
        require("nvim-dap-virtual-text").setup({
            commented = true,
        })

        local dap, dapui = require("dap"), require("dapui")
        dapui.setup({})

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- set up debugger
        for k, _ in pairs(opts.setup) do
            opts.setup[k](plugin, opts)
        end

        dap.set_log_level("TRACE")
    end,
}
