if not require("config").pde.lua then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "stylua" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.stylua)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			dap = {
				-- needed for dap handler to be attached
				name = "lua",
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
							},
							completion = { callSnippet = "Replace" },
							telemetry = { enable = false },
							hint = {
								enable = false,
							},
						},
					},
				},
			},
			setup = {
				lua_ls = function(_, _)
					local lsp_utils = require("base.lsp.utils")
					lsp_utils.on_attach(function(client, buffer)
                        -- stylua: ignore
                        if client.name == "lua_ls" then
                            vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
                                { buffer = buffer, desc = "OSV Run" })
                            vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
                                { buffer = buffer, desc = "OSV Launch" })
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
			{ "jbyuki/one-small-step-for-vimkind" },
		},
		opts = {
			setup = {
				osv = function(_, _)
					require("base.dap.lua").setup()
				end,
			},
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-plenary",
		},
		opts = function(_, opts)
			vim.list_extend(opts.adapters, {
				require("neotest-plenary"),
			})
		end,
	},
}
