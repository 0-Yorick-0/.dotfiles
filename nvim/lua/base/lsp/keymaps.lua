local M = {}

function M.on_attach(client, buffer)
    local opts = { buffer = buffer, remap = false }

    vim.keymap.set("n", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, { desc = "[G]o [D]efinition" })
    vim.keymap.set("n", "fmt", function()
        vim.lsp.buf.format({ async = true })
    end, { desc = "[F]or[M]a[T]" })
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, { desc = "[V]iew [D]iagnostic" })
    vim.keymap.set("n", "$d", function()
        vim.diagnostic.goto_next()
    end, { desc = "Next occurrence" })
    vim.keymap.set("n", "ùd", function()
        vim.diagnostic.goto_prev()
    end, { desc = "Previous occurence" })
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, { desc = "[V]iew [C]ode [A]ction" })
    vim.keymap.set("n", "<leader>vco", function()
        vim.lsp.buf.code_action({
            filter = function(code_action)
                if not code_action or not code_action.data then
                    return false
                end

                local data = code_action.data.id
                return string.sub(data, #data - 1, #data) == ":0"
            end,
            apply = true,
        })
    end, { desc = "[V]iew [C]ode actions [O]thers" })
    vim.keymap.set("n", "<leader>vcr", function()
        vim.lsp.buf.references()
    end, { desc = "[V]iew [C]ode [R]eferences" })
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, { desc = "[V]iew [R]e[N]ame" })
end

return M
