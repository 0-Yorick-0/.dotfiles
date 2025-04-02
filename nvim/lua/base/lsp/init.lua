return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>l"] = { name = "+LSP" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "j-hui/fidget.nvim", config = true },
			{ "echasnovski/mini.nvim", version = false },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			-- all servers are loaded in config.init, which is called in config.lazy.lua
			servers = {},
			setup = {},
		},
		config = function(plugin, opts)
			require("base.lsp.servers").setup(plugin, opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"shfmt",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.shfmt,
				},
			}
		end,
	},
	-- show lsp logs wit :OutputPanel or <leader>o
	{
		"mhanberg/output-panel.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("output_panel").setup({
				max_buffer_size = 5000, -- default
			})
		end,
		cmd = { "OutputPanel" },
		keys = {
			{
				"<leader>o",
				vim.cmd.OutputPanel,
				mode = "n",
				desc = "Toggle the output panel",
			},
		},
	},
}
