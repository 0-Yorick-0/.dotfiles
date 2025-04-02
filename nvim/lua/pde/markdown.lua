if not require("config").pde.markdown then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"markdownlint",
				"markdownlint-cli2",
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.code_actions.textlint)
			table.insert(opts.sources, nls.builtins.diagnostics.markdownlint)
			table.insert(opts.sources, nls.builtins.formatting.markdownlint)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				marksman = {},
			},
			setup = {
				marksman = function(_, opts) end,
			},
		},
	},
}
