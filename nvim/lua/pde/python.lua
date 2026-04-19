if not require("config").pde.python then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"pyright",
				"mypy",
				"pylint",
				"black",
				"reorder-python-imports",
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.mypy)
			table.insert(opts.sources, nls.builtins.formatting.pydoclint)
			table.insert(opts.sources, nls.builtins.formatting.pylint)
			table.insert(opts.sources, nls.builtins.formatting.black)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {},
				},
			},
			setup = {
				pyright = function(opts, _) end,
			},
		},
	},
}
