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
			vim.list_extend(
				opts.ensure_installed,
				{ "php-cs-fixer", "phpcbf", "phpcs", "phpmd", "phpstan", "intelephense" }
			)
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.phpcs)
			table.insert(opts.sources, nls.builtins.formatting.phpcbf)
			table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
		end,
	},
	{
		"phpactor/phpactor",
		dependencies = {
			{ "stephpy/vim-php-cs-fixer" },
			{ "squizlabs/PHP_CodeSniffer" },
			{ "neovim/nvim-lspconfig" },
		},
		ft = { "php", "cucumber" },
		branch = "master",
		build = "composer install -o",
	},
	{
		"neovim/nvim-lspconfig",
		servers = {
			dap = {
				-- needed for dap handler to be attached
				name = "phpactor",
			},
			phpactor = {
				-- init_options = {
				-- 	["language_server_phpstan.enabled"] = false,
				-- 	["language_server_psalm.enabled"] = false,
				-- },
			},
		},
		opts = {},
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
