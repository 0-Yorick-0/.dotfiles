-- Debugger
return {
	"mfussenegger/nvim-dap",
	lazy = true,
	event = "BufReadPre",
	module = { "dap" },
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		-- create a beautiful debugger UI
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		{ "leoluz/nvim-dap-go", module = "dap-go" },
		{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
	},
	config = function()
		require("main.dap").setup()
	end,
}
