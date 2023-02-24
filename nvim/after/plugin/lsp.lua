-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'dockerls',
    'sqlls',
    'jsonls',
    'marksman',
    'yamlls',
    'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

local function config(_config)
    return vim.tbl_deep_extend("force", {

        on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end
    }, _config or {})
end

require("lspconfig").phpactor.setup(config({
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    },

    on_attach = function()
        print('phpactor loaded')
        vim.keymap.set("n", "gd", ":PhpactorGotoDefinition<CR>")
        vim.keymap.set("n", "gdv", ":PhpactorGotoDefinition vsplit<CR>")
        vim.keymap.set("n", "<leader>j", ":PhpactorImportClass<CR>")
        vim.keymap.set("n", "<leader>cf", ":PhpactorCopyFile<CR>")
        vim.keymap.set("n", "<leader>cc", ":PhpactorCopyClassName<CR>")
        -- find usages in quifix list
        vim.keymap.set("n", "<leader>fr", ":PhpactorFindReferences<CR>")
        -- jump to parent class
        vim.keymap.set("n", "<leader>nv", ":PhpactorNavigate<CR>")
    end,

    filetypes = { 'php', 'cucumber' }
}))



require("lspconfig").gopls.setup(config({
    cmd = { "gopls", "serve" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}))

---------------------------------
-- Formatting
---------------------------------
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
    sources = {
        formatting.black,
        formatting.rustfmt,
        formatting.phpcsfixer,
        formatting.prettier,
        formatting.stylua,
        formatting.gofmt,
        formatting.goimports,
        formatting.sqlformat,
        formatting.terraform_fmt,
        formatting.markdownlint,
    },
    on_attach = function(client, bufnr)
        if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
            client.resolved_capabilities.document_formatting = false
        end

        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
})

---------------------------------
-- Auto commands
---------------------------------
vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])

lsp.setup()
