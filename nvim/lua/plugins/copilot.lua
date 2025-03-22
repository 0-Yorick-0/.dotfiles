return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		enabled = true,
		cmd = "Copilot",
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"giuxtaposition/blink-cmp-copilot",
	},
}
