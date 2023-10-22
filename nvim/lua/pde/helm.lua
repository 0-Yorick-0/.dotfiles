if not require("config").pde.helm then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"go",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				helm_ls = {},
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local null_ls = require("null-ls")
			vim.list_extend(opts.sources, {
				-- null_ls.builtins.formatting.golangci_lint,
			})
		end,
	},
	{
		"towolf/vim-helm",
	},
}
