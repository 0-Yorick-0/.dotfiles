return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ":TSUpdate",
        event = "BufReadPost",
        opts = {
            sync_install = false,
            ensure_installed = {
                --"help",
                "javascript",
                "json",
                "lua",
                "go",
                "gomod",
                "python",
                "rust",
                "tsx",
                "typescript",
                "bash",
                "dockerfile",
                "html",
                "markdown",
                "markdown_inline",
                "org",
                "query",
                "regex",
                "latex",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = { enable = true },
            indent = { enable = true, disable = { "python" } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = nil,
                    swap_previous = nil,
                },
            },
        },
        config = function(_, opts)
            local swap_next, swap_prev = (function()
                local swap_objects = {
                    p = "@parameter.inner",
                    f = "@function.outer",
                    c = "@class.outer",
                }

                local n, p = {}, {}
                for key, obj in pairs(swap_objects) do
                    n[string.format("<leader>cx%s", key)] = obj
                    p[string.format("<leader>cX%s", key)] = obj
                end

                return n, p
            end)()
            opts.textobjects.swap.swap_next = swap_next
            opts.textobjects.swap.swap_prev = swap_prev

            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
