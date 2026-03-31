if not require("config").pde.helm then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.filetype.add({
				extension = {
					gotmpl = "gotmpl",
				},
				pattern = {
					[".*/templates/.*%.tpl"] = "helm",
					[".*/templates/.*%.ya?ml"] = "helm",
					["helmfile.*%.ya?ml"] = "helm",
					[".*cloud/.*%.gotmpl"] = "helm",
				},
			})
			vim.list_extend(opts.ensure_installed, {
				"go",
				"gotmpl",
				"helm",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"golangci-lint",
				"gofumpt",
				"yamllint",
				"yamlfmt",
				"golangci-lint-langserver",
				-- if necessary, install gopls manually with  go install -v golang.org/x/tools/gopls@latest
				"gopls",
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
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.goimports)
			table.insert(opts.sources, nls.builtins.formatting.gofumpt)
			table.insert(opts.sources, nls.builtins.formatting.yamlfmt)
			table.insert(opts.sources, nls.builtins.diagnostics.golangci_lint)
			table.insert(opts.sources, nls.builtins.diagnostics.yamllint)
		end,
	},
	{
		"towolf/vim-helm",
	},
}
