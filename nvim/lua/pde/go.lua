if not require("config").pde.go then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "go", "gomod" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"delve",
				"gotests",
				"golangci-lint",
				"gofumpt",
				"goimports",
				"golangci-lint-langserver",
				"impl",
				"gomodifytags",
				"iferr",
				"gotestsum",
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.goimports)
			table.insert(opts.sources, nls.builtins.formatting.gofumpt)
		end,
	},
	{
		"fatih/vim-go",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		-- event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ":GoInstallBinaries", -- if you need to install/update all binaries
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			dap = {
				-- needed for dap handler to be attached
				name = "go",
			},
			servers = {
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							staticcheck = true,
							semanticTokens = true,
						},
					},
				},
			},
			setup = {
				gopls = function(_, _)
					local lsp_utils = require("base.lsp.utils")
					lsp_utils.on_attach(function(client, bufnr)
						local map = function(mode, lhs, rhs, desc)
							if desc then
								desc = desc
							end
							vim.keymap.set(
								mode,
								lhs,
								rhs,
								{ silent = true, desc = desc, buffer = bufnr, noremap = true }
							)
						end
                        -- stylua: ignore
                        if client.name == "gopls" then
                            map("n", "<leader>ly", "<cmd>GoModTidy<cr>", "Go Mod Tidy")
                            map("n", "<leader>lc", "<cmd>GoCoverage<Cr>", "Go Test Coverage")
                            map("n", "<leader>lt", "<cmd>GoTest<Cr>", "Go Test")
                            map("n", "<leader>lR", "<cmd>GoRun<Cr>", "Go Run")
                            map("n", "<leader>dT", "<cmd>lua require('dap-go').debug_test()<cr>", "Go Debug Test")
                        end
					end)
				end,
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			opts = {
				setup = {
					go = function(_, opts)
						require("base.dap.go").setup(opts)
					end,
				},
			},
		},
	},
}
