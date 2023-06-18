---------------------------------
-- Formatting
---------------------------------
return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        -- see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        null_ls.setup({
            sources = {
                -- formatting
                formatting.black,
                formatting.rustfmt,
                formatting.phpcsfixer,
                formatting.prettier,
                formatting.stylua,
                formatting.gofmt,
                formatting.goimports,
                formatting.sqlformat,
                formatting.terraform_fmt,
                formatting.yamlfmt,
            },
            on_attach = function(client, bufnr)
                if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
                    client.resolved_capabilities.document_formatting = false
                end

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end
}
