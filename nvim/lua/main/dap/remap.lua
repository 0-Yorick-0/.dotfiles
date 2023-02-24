local M = {}

-- local function keymap(lhs, rhs, desc)
--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
-- end

function M.setup()
    vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>",
        { silent = true, noremap = false, desc = "Toggle UI" })
    vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        { silent = true, noremap = false, desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
        { silent = true, noremap = false, desc = "Conditional Breakpoint" })

    -- Run
    vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>",
        { silent = true, noremap = false, desc = "Start" })
    vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>",
        { silent = true, noremap = false, desc = "Pause" })
    vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>",
        { silent = true, noremap = false, desc = "Quit" })
    vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",
        { silent = true, noremap = false, desc = "Disconnect" })
    vim.keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>",
        { silent = true, noremap = false, desc = "Terminate" })


    -- Navigation
    vim.keymap.set("n", "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>",
        { silent = true, noremap = false, desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",
        { silent = true, noremap = false, desc = "Step Back" })
    vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",
        { silent = true, noremap = false, desc = "Continue" })
    vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",
        { silent = true, noremap = false, desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",
        { silent = true, noremap = false, desc = "Step Over" })
    vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",
        { silent = true, noremap = false, desc = "Step Out" })


    -- Test && Evaluate
    vim.keymap.set("v", "<leader>ee", "<cmd>lua require'dapui'.eval()<cr>",
        { silent = true, noremap = true, desc = "Evaluate" })
    vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>",
        { silent = true, noremap = false, desc = "Evaluate" })
    vim.keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
        { silent = true, noremap = false, desc = "Evaluate Input" })
    vim.keymap.set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>",
        { silent = true, noremap = false, desc = "Hover Variables" })

    vim.keymap.set("n", "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>",
        { silent = true, noremap = false,
            desc = "Scopes" })
    vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { silent = true, noremap = false,
        desc = "Toggle Repl" })
    vim.keymap.set("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>",
        { silent = true, noremap = false, desc = "Get Session" })

end

return M
