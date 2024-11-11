-- Debugger
return {
	"mfussenegger/nvim-dap",
	lazy = false,
	enabled = true,
	event = "BufReadPre",
	module = { "dap" },
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		-- create a beautiful debugger UI
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		-- help to install debuggers
		"Pocco81/DAPInstall.nvim",
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
	},
	opts = {},
	config = function(plugin, opts)
		require("base.dap.config").setup()
		require("nvim-dap-virtual-text").setup({
			commented = true,
		})

		local dap, dapui = require("dap"), require("dapui")

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
		wk = require("which-key")
		wk.add({
			{ "<leader>d", group = "Debugger" },
			{ "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
			{ "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{
				"<leader>dC",
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
				desc = "Conditional Breakpoint",
			},
			{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
			{ "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", desc = "Pause" },
			{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
			{ "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" },
			{ "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run to Cursor" },
			{ "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
			{ "<leader>dc", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
			{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
			{ "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
			{
				"<leader>dl",
				"<cmd>lua require'dap'.set_breakpoint(nil, desc= vim.fn.input('Exception: '))<cr>",
				desc = "Exception Breakpoint",
			},
			{ "<leader>de", "<cmd>lua require'dap'.repl.run_last()<cr>", desc = "Run Last" },
			{
				"<leader>dE",
				"<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
				desc = "Evaluate Input",
			},
			{ "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Hover Variables" },
			{ "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", desc = "Scopes" },
			{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
			{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
		})
	end,
}
