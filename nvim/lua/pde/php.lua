if not require("config").pde.php then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "php", "phpdoc" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "php-cs-fixer", "phpcbf", "phpcs", "phpmd", "phpstan" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			-- table.insert(opts.sources, nls.builtins.formatting.phpcs)
			-- table.insert(opts.sources, nls.builtins.formatting.phpcbf)
			table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
			table.insert(
				opts.sources,
				nls.builtins.formatting.pretty_php.with({
					extra_args = {},
				})
			)
		end,
	},
	{
		"phpactor/phpactor",
		dependencies = {
			-- { "stephpy/vim-php-cs-fixer" },
			-- snippets
			"h4kst3r/php-awesome-snippets", -- vscode extension
			{ "gbprod/php-enhanced-treesitter.nvim" },
			{ "squizlabs/PHP_CodeSniffer" },
			{ "neovim/nvim-lspconfig" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		ft = { "php", "cucumber" },
		branch = "master",
		build = "composer install -o",
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				phpactor = {},
			},
			setup = {
				phpactor = function(_, _)
					init_options = {
						["language_server.diagnostics_on_update"] = false,
						["language_server.diagnostics_on_open"] = false,
						["language_server.diagnostics_on_save"] = false,
						["language_server_phpstan.enabled"] = false,
						["language_server_psalm.enabled"] = false,
						["language_server_php_cs_fixer.enabled"] = false,
					}
					local lsp_utils = require("base.lsp.utils")
					lsp_utils.on_attach(function(client, bufnr)
						if client.name == "phpactor" then
							local wk = require("which-key")
							wk.add({

								{ "<leader>p", group = "PHP" },
								{ "<leader>pgd", "<cmd>PhpactorGotoDefinition<CR>", desc = "[G]oto[D]efinition" },
								{
									"<leader>pgdv",
									"<cmd>PhpactorGotoDefinition vsplit<CR>",
									desc = "[G]oto[D]efinition [v]split",
								},
								{ "<leader>pi", "<cmd>PhpactorImportClass<CR>", desc = "[I]mportClass" },
								{ "<leader>pcf", "<cmd>PhpactorCopyFile<CR>", desc = "[C]opy[F]ile" },
								{ "<leader>pcc", "<cmd>PhpactorCopyClassName<CR>", desc = "[C]opy[C]lassName" },
								-- find usages in quifix list
								{ "<leader>pfr", "<cmd>PhpactorFindReferences<CR>", desc = "[F]ind[R]eferences" },
								-- jump to parent class
								{ "<leader>pnv", "<cmd>PhpactorNavigate<CR>", desc = "[N]a[v]igate" },
								{
									"<leader>pim",
									"<cmd>PhpactorGotoImplementations<CR>",
									desc = "Go to [Im]plementations",
								},
								-- open context menu
								{ "<leader>pcm", "<cmd>PhpactorContextMenu<CR>", desc = "Open [C]ontext[M]enu" },
								{ "<leader>ptr", "<cmd>PhpactorTransform<CR>", desc = "Open [Tr]ansform" },
							})
						end
					end)
				end,
			},
		},
	},
	-- Debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"xdebug/vscode-php-debug",
		},
		build = "npm install && npm run build",
		opts = {
			setup = {
				xdebug = function(_, _)
					require("base.dap.php").setup()
				end,
			},
		},
	},
}
