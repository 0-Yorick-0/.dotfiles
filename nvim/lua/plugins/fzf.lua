return {
	"junegunn/fzf.vim",
	dependencies = { "junegunn/fzf" },
	config = function()
		local ok, fzf = pcall(require, "fzf")
		if not ok then
			print(string.format("Someting happend on calling fzf in %s", vim.fn.expand("%:p")))
		end

		vim.g.fzf_layout = { window = { width = 0.9, height = 0.9 } }
		vim.keymap.set("n", "<leader>F", "<cmd>FZF<cr>", { silent = true, noremap = true })
	end,
}
