return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            lazy = false,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-lua/plenary.nvim",
        'nvim-telescope/telescope-symbols.nvim',
        'ThePrimeagen/harpoon',
        'ThePrimeagen/git-worktree.nvim',
        "sharkdp/fd",
    },
    config = function()
        local ok, telescope = pcall(require, "telescope")
        if not ok then
            print(string.format("Someting happend on calling telescope in %s", vim.fn.expand("%:p")))
        end

        telescope.setup({
            defaults = {
                file_ignore_patterns = { "%.git/" },
                color_devicons = true,
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
                        require("telescope.themes").get_dropdown({
                            layout_strategy = "vertical",
                            layout_config = "bottom",
                            prompt_position = "bottom",
                            vertical = {
                                width = 0.5,
                                height = 20,
                            },
                        }),
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
                        end,
                    },
                },
            },
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension('harpoon')
        telescope.load_extension('git_worktree')

        local function find_in_all_files()
            require("telescope.builtin").find_files({ no_ignore = true })
        end

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind in [F]iles" })
        vim.keymap.set("n", "<leader>fa", find_in_all_files, { desc = "[F]ind in [a]ll files" })
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind in [G]it files" })
        vim.keymap.set("n", "<leader>ç", builtin.oldfiles, { desc = "[ç] Find recently opened files" })
        vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymap" })
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "[L]ive [G]rep" })
        vim.keymap.set("n", "<leader>lga", function()
            builtin.live_grep({ additional_args = { "--no-ignore" } })
        end, { desc = "[L]ive [G]rep in [A]ll files" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
        vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "[F]ind [Q]uickfix" })
        vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "[F]ind [S]ymbols" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
        vim.keymap.set('n', '<leader>fS', require('telescope.builtin').git_status, { desc = '' })
        vim.keymap.set('n', '<leader>fm', ":Telescope harpoon marks<CR>", { desc = 'Harpoon [M]arks' })
        vim.keymap.set("n", "<Leader>fr", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
            { silent = true })
        vim.keymap.set("n", "<Leader>fR",
            "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>fn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>",
            { silent = true })
    end,
}
