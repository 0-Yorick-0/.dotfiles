local M = {}

local function configure()
	dapui = require("dapui")

	local dap_breakpoint = {
		error = {
			text = "🟥",
			texthl = "LspDiagnosticsSignError",
			linehl = "",
			numhl = "",
		},
		rejected = {
			text = "",
			texthl = "LspDiagnosticsSignHint",
			linehl = "",
			numhl = "",
		},
		stopped = {
			text = "⭐️",
			texthl = "LspDiagnosticsSignInformation",
			linehl = "DiagnosticUnderlineInfo",
			numhl = "LspDiagnosticsSignInformation",
		},
	}

	vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
	vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
	require("nvim-dap-virtual-text").setup({
		commented = true,
	})

	local dap, dapui = require("dap"), require("dapui")
	-- Dap UI setup
	dapui.setup({})
	-- For more information, see |:help nvim-dap-ui|
	-- dapui.setup({
	-- 	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	-- 	controls = {
	-- 		icons = {
	-- 			pause = "⏸",
	-- 			play = "▶",
	-- 			step_into = "⏎",
	-- 			step_over = "⏭",
	-- 			step_out = "⏮",
	-- 			step_back = "b",
	-- 			run_last = "▶▶",
	-- 			terminate = "⏹",
	-- 		},
	-- 	},
	-- 	layouts = {
	-- 		{
	-- 			elements = {
	-- 				{
	-- 					id = "scopes",
	-- 					size = 0.40,
	-- 				},
	-- 				"breakpoints",
	-- 			},
	-- 			position = "bottom",
	-- 			size = 0.25, -- 25% of total lines
	-- 		},
	-- 		{
	-- 			elements = {
	-- 				"repl",
	-- 				"console",
	-- 			},
	-- 			position = "left",
	-- 			size = 40, -- 40 columns
	-- 		},
	-- 	},
	-- 	floating = {
	-- 		max_height = nil, -- These can be integers or a float between 0 and 1.
	-- 		max_width = nil, -- Floats will be treated as percentage of your screen.
	-- 		border = "single", -- Border style. Can be "single", "double" or "rounded"
	-- 		mappings = {
	-- 			close = { "q", "<Esc>" },
	-- 		},
	-- 	},
	-- 	windows = { indent = 1 },
	-- 	render = {
	-- 		max_type_length = nil, -- Can be integer or nil.
	-- 	},
	-- })
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

local function configure_debuggers()
	require("main.dap.lua").setup()
	require("main.dap.go").setup()
	require("main.dap.php").setup()
end

function M.setup()
	configure() -- Configuration
	configure_exts() -- Extensions
	configure_debuggers() -- Debugger
	require("main.dap.remap").setup() -- Keymaps
end

require("dap").set_log_level("TRACE")
return M
