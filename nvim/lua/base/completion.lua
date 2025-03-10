return {
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	{
		"andymass/vim-matchup",
		event = { "BufReadPost" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua", -- Optional
			"honza/vim-snippets",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = require("cmp.config.compare")
			local kind_icons = require("config.icons").kind

			local source_names = {
				copilot = "(Copilot)",
				nvim_lsp = "(LSP)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
				path = "(Path)",
			}
			local duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
				luasnip = 1,
			}
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.score,
						compare.recently_used,
						compare.offset,
						compare.exact,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<S-Tab>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping({
						i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
						c = function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
					}),
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, {
						"i",
						"s",
						"c",
					}),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
						"c",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 1 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "luasnip", group_index = 2 },
					{ name = "buffer", group_index = 3 },
					{ name = "path", group_index = 3 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						local duplicates_default = 0
						item.kind = string.format("%s", kind_icons[item.kind]) .. " " .. item.kind

						if entry.source.name == "copilot" then
							item.kind = kind_icons.Copilot
							item.kind_hl_group = "CmpItemKindCopilot"
						end

						if entry.source.name == "emoji" then
							item.kind = kind_icons.misc.Smiley
							item.kind_hl_group = "CmpItemKindEmoji"
						end

						item.menu = source_names[entry.source.name]
						item.dup = duplicates[entry.source.name] or duplicates_default
						return item
					end,
				},
				experimental = {
					hl_group = "LspCodeLens",
					ghost_text = {},
				},
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
					},
				},
			}
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			{ "honza/vim-snippets" },
			{
				-- load snippets. See https://github.com/honza/vim-snippets/blob/master/snippets/php.snippets
				-- for list of snippets shortcuts
				"rafamadriz/friendly-snippets",
				config = function()
					-- require("luasnip.loaders.from_vscode").lazy_load()
					-- required to enable snippets from honza/vim-snippets
					require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading
				end,
			},
		},
		build = "make install_jsregexp",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
        -- stylua: ignore
        keys = {
            {
                "<C-;>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
                end,
                expr = true,
                remap = true,
                silent = true,
                mode = "i",
            },
            { "<C-j>", function() require("luasnip").jump(1) end,  mode = "s" },
            { "<C-,>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
		config = function(_, opts)
			require("luasnip").setup(opts)
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				},
			}
		end,
	},
	-- inlay hints
	{
		"simrat39/inlay-hints.nvim",
		config = function()
			require("inlay-hints").setup({
				only_current_line = false,
				eol = {
					right_align = false,
				},
			})
		end,
	},
	-- test plugins are here because they depend on completion
	-- which is loaded before them
	{
		"vim-test/vim-test",
		opts = {
			setup = {},
		},
		config = function(plugin, opts)
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#term_position"] = "belowright"
			vim.g["test#neovim#preserve_screen"] = 1

			-- Set up vim-test
			for k, _ in pairs(opts.setup) do
				opts.setup[k](plugin, opts)
			end
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
			"vim-test/vim-test",
			"stevearc/overseer.nvim",
		},

		opts = function()
			return {
				adapters = {
					require("neotest-vim-test")({
						ignore_file_types = { "python", "vim", "lua" },
					}),
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
				-- overseer.nvim
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				overseer = {
					enabled = true,
					force_default = true,
				},
			}
		end,
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			local wk = require("which-key")
			wk.add({
				{ "<leader>t", group = "Tests" },
				{
					"<leader>td",
					"<cmd>w|lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
					desc = "Debug File",
				},
				{
					"<leader>tL",
					"<cmd>w|lua require('neotest').run.run_last({strategy = 'dap'})<cr>",
					desc = "Debug Last",
				},
				{
					"<leader>ta",
					"<cmd>w|lua require('neotest').run.attach()<cr>",
					desc = "Attach",
				},
				{
					"<leader>tf",
					"<cmd>w|lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
					desc = "File",
				},
				{
					"<leader>tF",
					"<cmd>w|lua require('neotest').run.run(vim.loop.cwd())<cr>",
					desc = "All Files",
				},
				{
					"<leader>tl",
					"<cmd>w|lua require('neotest').run.run_last()<cr>",
					desc = "Last",
				},
				{
					"<leader>tn",
					"<cmd>w|lua require('neotest').run.run()<cr>",
					desc = "Nearest",
				},
				{
					"<leader>tN",
					"<cmd>w|lua require('neotest').run.run({strategy = 'dap'})<cr>",
					desc = "Debug Nearest",
				},
				{
					"<leader>to",
					"<cmd>w|lua require('neotest').output.open({ enter = true })<cr>",
					desc = "Output",
				},
				{
					"<leader>ts",
					"<cmd>w|lua require('neotest').run.stop()<cr>",
					desc = "Stop",
				},
				{
					"<leader>tS",
					"<cmd>w|lua require('neotest').summary.toggle()<cr>",
					desc = "Summary",
				},
			})
			require("neotest").setup(opts)
		end,
	},
}
