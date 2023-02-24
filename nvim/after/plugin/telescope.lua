local ok, telescope = pcall(require, "telescope")
if not ok then
    print(string.format("Someting happend on calling telescope in %s", vim.fn.expand('%:p')))
end

telescope.setup({
    defaults = {
        file_ignore_patterns = { "%.git/" }
    },
    {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown(
                    {
                        layout_strategy = "vertical",
                        layout_config = "bottom",
                        prompt_position = "bottom",
                        vertical = {
                            width = 0.5,
                            height = 20,
                        }
                    }
                )
            },
        },
        pickers = {
            find_files = {
                hidden = true,
                no_ignore = true,
            },
            live_grep = {
                additional_args = function(opts)
                    return { "--hidden" }
                end
            },
        }
    }
})
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set("n", '<leader>ff', builtin.find_files, { desc = "[F]ind in all [F]iles" })
vim.keymap.set("n", '<leader>fg', builtin.git_files, { desc = "[F]ind in [G]it files" })
vim.keymap.set("n", "<leader>ç", builtin.oldfiles, { desc = "[ç] Find recently opened files" })
vim.keymap.set("n", '<leader><space>', builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", '<leader>fh', builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymap" })
vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "[L]ive [G]rep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "[F]ind [S]ymbols" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
