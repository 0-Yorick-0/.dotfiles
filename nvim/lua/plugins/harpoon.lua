return {
	"ThePrimeagen/harpoon",
	config = function()
		vim.g.harpoon_log_level = debug
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-y>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-h>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<C-t>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<C-s>", function()
			ui.nav_file(4)
		end)
	end,
}
