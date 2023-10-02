return {
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                messages = {
                    enabled = false,
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        -- Set lualine as statusline
        -- See `:help lualine.txt`
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "powerline",
                    component_separators = "|",
                    section_separators = "",
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            separator = { left = "", right = "" },
                            icons_enabled = true,
                            icon = "",
                            symbols = {
                                modified = "",
                                readonly = "",
                            },
                        },
                        {
                            'filename',
                            file_status = true,     -- Displays file status (readonly status, modified status)
                            newfile_status = false, -- Display new file status (new file means no write after created)
                            path = 0,               -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory

                            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                            -- for other components. (terrible name, any suggestions?)
                            symbols = {
                                modified = '[+]',      -- Text to show when the file is modified.
                                readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                                newfile = '[New]',     -- Text to show for newly created file before first write
                            }
                        },
                        {
                            'filetype',
                            colored = true, -- displays filetype highlight (if available)
                            icon_only = true,
                            icon = { align = "right" },
                        },
                    },
                    lualine_b = {},
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                        },
                        {
                            'filetype',
                            colored = true, -- displays filetype highlight (if available)
                            icon_only = true,
                            icon = { align = "left" },
                        },
                    },
                    lualine_x = { 'encoding' },
                    lualine_y = {
                        {
                            'progress',
                            separator = { left = "", right = "" },
                        },
                    },
                    lualine_z = {
                        {
                            'location',
                            separator = { left = "", right = "" },
                        },
                    }
                },
                inactive_sections = {}
            })
        end,
    },
    {
        "HampusHauffman/block.nvim",
        config = function()
            require("block").setup({})
            vim.keymap.set("n", "<leader>b", ":Block<cr>")
        end,
    },
}
