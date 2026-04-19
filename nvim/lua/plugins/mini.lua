return {
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				},
			}
		end,
	},
	{
		"echasnovski/mini.splitjoin",
		config = function()
			local miniSplitJoin = require("mini.splitjoin")
			miniSplitJoin.setup({
				mappings = { toggle = "" }, -- Disable default mapping
			})
			vim.keymap.set({ "n", "x" }, "sj", function()
				miniSplitJoin.join()
			end, { desc = "Join arguments" })
			vim.keymap.set({ "n", "x" }, "sk", function()
				miniSplitJoin.split()
			end, { desc = "Split arguments" })
		end,
	},
}
