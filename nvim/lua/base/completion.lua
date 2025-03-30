local trigger_text = ";"

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
		"saghen/blink.cmp",
		enabled = true,
		-- optional: provides snippets for the snippet source
		dependencies = {
			"honza/vim-snippets",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
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
			"moyiz/blink-emoji.nvim",
			"Kaiser-Yang/blink-cmp-dictionary",
			"onsails/lspkind.nvim",
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- Disable blink for telescope since it slows down the picker
			enabled = function()
				-- Get the current buffer's filetype
				local filetype = vim.bo[0].filetype
				-- Disable for Telescope buffers
				if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
					return false
				end
				return true
			end,
			keymap = {
				preset = "default",
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<S-k>"] = { "scroll_documentation_up", "fallback" },
				["<S-j>"] = { "scroll_documentation_down", "fallback" },

				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
			},
			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},
			snippets = { preset = "luasnip" },
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot", "emoji", "dictionary" },
				providers = {
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						min_keyword_length = 2,
						-- When linking markdown notes, I would get snippets and text in the
						-- suggestions, I want those to show only if there are no LSP
						-- suggestions
						--
						-- Enabled fallbacks as this seems to be working now
						-- Disabling fallbacks as my snippets wouldn't show up when editing
						-- lua files
						-- fallbacks = { "snippets", "buffer" },
						score_offset = 90, -- the higher the number, the higher the priority
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 25,
						-- When typing a path, I would get snippets and text in the
						-- suggestions, I want those to show only if there are no path
						-- suggestions
						fallbacks = { "snippets", "buffer" },
						-- min_keyword_length = 2,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},
					buffer = {
						name = "Buffer",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 4,
						score_offset = 15, -- the higher the number, the higher the priority
					},
					snippets = {
						name = "snippets",
						enabled = true,
						max_items = 15,
						min_keyword_length = 2,
						module = "blink.cmp.sources.snippets",
						score_offset = 85, -- the higher the number, the higher the priority
						-- Only show snippets if I type the trigger_text characters, so
						-- to expand the "bash" snippet, if the trigger_text is ";" I have to
						should_show_items = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							-- NOTE: remember that `trigger_text` is modified at the top of the file
							return before_cursor:match(trigger_text .. "%w*$") ~= nil
						end,
						-- After accepting the completion, delete the trigger_text characters
						-- from the final inserted text
						-- Modified transform_items function based on suggestion by `synic` so
						-- that the luasnip source is not reloaded after each transformation
						-- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
						-- NOTE: I also tried to add the ";" prefix to all of the snippets loaded from
						-- friendly-snippets in the luasnip.lua file, but I was unable to do
						-- so, so I still have to use the transform_items here
						-- This removes the ";" only for the friendly-snippets snippets
						transform_items = function(_, items)
							local line = vim.api.nvim_get_current_line()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = line:sub(1, col)
							local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
							if start_pos then
								for _, item in ipairs(items) do
									if not item.trigger_text_modified then
										---@diagnostic disable-next-line: inject-field
										item.trigger_text_modified = true
										item.textEdit = {
											newText = item.insertText or item.label,
											range = {
												start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
												["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
											},
										}
									end
								end
							end
							-- NOTE: After the transformation, I have to reload the luasnip source
							-- Otherwise really crazy shit happens and I spent way too much time
							-- figuring this out
							vim.schedule(function()
								require("blink.cmp").reload("snippets")
							end)
							return items
						end,
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
						min_keyword_length = 2,
						score_offset = 85, -- the higher the number, the higher the priority
					},
					-- https://github.com/moyiz/blink-emoji.nvim
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 93, -- the higher the number, the higher the priority
						min_keyword_length = 2,
						opts = { insert = true }, -- Insert emoji (default) or complete its name
					},
					-- https://github.com/Kaiser-Yang/blink-cmp-dictionary
					-- In macOS to get started with a dictionary:
					-- cp /usr/share/dict/words ~/github/dotfiles-latest/dictionaries/words.txt
					--
					-- NOTE: For the word definitions make sure "wn" is installed
					-- brew install wordnet
					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						score_offset = 20, -- the higher the number, the higher the priority
						-- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
						enabled = true,
						max_items = 8,
						min_keyword_length = 3,
						opts = {
							-- -- The dictionary by default now uses fzf, make sure to have it
							-- -- installed
							-- -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
							--
							-- Do not specify a file, just the path, and in the path you need to
							-- have your .txt files
							dictionary_directories = { vim.fn.expand("$MY_NEOVIM/dictionaries") },
							-- Notice I'm also adding the words I add to the spell dictionary
							dictionary_files = {
								vim.fn.expand("$MY_NEOVIM/spell/en.utf-8.add"),
								vim.fn.expand("$MY_NEOVIM/spell/fr.utf-8.add"),
							},
							-- --  NOTE: To disable the definitions uncomment this section below
							--
							-- separate_output = function(output)
							--   local items = {}
							--   for line in output:gmatch("[^\r\n]+") do
							--     table.insert(items, {
							--       label = line,
							--       insert_text = line,
							--       documentation = nil,
							--     })
							--   end
							--   return items
							-- end,
						},
					},
					-- -- Third class citizen mf always talking shit
					copilot = {
						name = "copilot",
						enabled = true,
						module = "blink-cmp-copilot",
						min_keyword_length = 4,
						score_offset = -100, -- the higher the number, the higher the priority
						async = true,
					},
				},
			},

			cmdline = {
				enabled = true,
			},

			completion = {
				menu = {
					border = "single",
					draw = {
						columns = {
							{ "kind_icon" },
							{ "kind" }, -- <- Useful for debugging highlights/completion types.
							{ "label", "label_description", gap = 1 },
							{ "source_name" }, -- <- Useful for debugging sources.
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local lspkind = require("lspkind")
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = "single",
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
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
