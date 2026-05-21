if not require("config").pde.bash then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "bash" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"bash-language-server",
				"shfmt",
				"dotenv-linter",
				"shellcheck",
				"shellharden",
				"beautysh",
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.shfmt)
			table.insert(opts.sources, nls.builtins.formatting.shellharden)
			table.insert(opts.sources, nls.builtins.diagnostics.dotenv_linter)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				bash_lsp_server = {
					settings = {},
				},
			},
			setup = {
				bash_lsp_server = function(opts, _) end,
			},
		},
	},
}
