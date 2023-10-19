local M = {}

M.setup = function()
    local cmp = require("cmp")
    local cmp_action = require("lsp-zero").cmp_action()
    local kind_icons = require("config.icons").kind

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        preselect = "item",
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            -- ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            -- Navigate between snippet placeholder
            ["<C-f>"] = cmp_action.luasnip_jump_forward(),
            ["<C-b>"] = cmp_action.luasnip_jump_backward(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<Tab>"] = nil,
            ["<S-Tab>"] = nil,
        },
        sources = {
            { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "emoji" },
            { name = "path" },
        },
        formatting = {
            fields = { "abbr", "menu", "kind" },
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

                if entry.source.name == "copilot" then
                    vim_item.kind = kind_icons.Copilot
                    vim_item.kind_hl_group = "CmpItemKindCopilot"
                end

                if entry.source.name == "emoji" then
                    vim_item.kind = kind_icons.misc.Smiley
                    vim_item.kind_hl_group = "CmpItemKindEmoji"
                end

                -- This concatenates the icons with the name of the item kind
                vim_item.menu = ({
                    copilot = "[Copilot]",
                    luasnip = "LuaSnip",
                    nvim_lsp = "[LSP]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    })
end
