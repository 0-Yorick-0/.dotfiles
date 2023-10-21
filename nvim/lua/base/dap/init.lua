-- Debugger
return {
	"mfussenegger/nvim-dap",
	lazy = false,
	enabled = true,
	event = "BufReadPre",
	module = { "dap" },
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		-- help to install debuggers
		"Pocco81/DAPInstall.nvim",
		-- create a beautiful debugger UI
		"rcarriga/nvim-dap-ui",
		-- which key integration
		{
			"folke/which-key.nvim",
			opts = {
				defaults = {
					["<leader>d"] = { name = "+debug" },
					["<leader>da"] = { name = "+adapters" },
				},
			},
		},
		"nvim-telescope/telescope-dap.nvim",
		{ "leoluz/nvim-dap-go", module = "dap-go" },
		{ "xdebug/vscode-php-debug", build = "npm install && npm run build" },
		{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
	},
	opts = {},
	config = function(plugin, opts)
		require("plugins.dap.mapping").setup()
		require("nvim-dap-virtual-text").setup({
			commented = true,
		})

		local dap, dapui = require("dap"), require("dapui")
		dapui.setup({})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- set up debugger
		for k, _ in pairs(opts.setup) do
			opts.setup[k](plugin, opts)
		end
	end,
}
