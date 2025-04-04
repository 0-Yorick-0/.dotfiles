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
		"yanskun/gotests.nvim",
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
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
						vim.api.nvim_create_autocmd("FileType", {
							pattern = "godoc",
							callback = function()
								if vim.bo.filetype == "godoc" then
									vim.bo.filetype = "go"
								end
							end,
						})
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
                            local wk = require("which-key")
                            wk.add({
                                {"<leader>G", group = "Go"},
                                { "<leader>Gi","<cmd>GoCallers<CR>", desc = "[F]ind[R]eferences" },
                                { "<leader>Gd","<cmd>GoDef<CR>", desc = "go to [D]efintion" },
                                {"<leader>Gim", "<cmd>GoImplements<CR>", desc= "go to [Im]plementations" },
                                {"<leader>Grl", "<cmd>GoModReload<CR>", desc= "[R]eload Modules" },
                                {"<leader>Gimp", "<cmd>GoImport<CR>", desc= "[Imp]ort module" },
                                {"<leader>Gx", "<cmd>GoDocBrowser<CR>", desc= "[Doc] in Browser" },
                                {"<leader>Grn", "<cmd>GoRename<CR>", desc= "[R]ename" },
                                {"<leader>Gt", "<cmd>GoTest<CR>", desc= "[T]est" },
                                {"<leader>Gtf", "<cmd>GoTestFunc<CR>", desc= "[T]est[F]unction" },
                                {"<leader>Gat", "<cmd>GoAddTest<CR>", desc= "[A]dd[T]est" },
                            })
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
					go = function()
						require("base.dap.go").setup()
					end,
				},
			},
		},
	},
}
