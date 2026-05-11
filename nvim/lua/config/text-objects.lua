local M = {}
-- allow to select or operate between special characters
M.basic_text_objects = function()
	local chars = { "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" }
	local desc = "allow to select or operate between character %s"

	for _, char in ipairs(chars) do
		for _, mode in ipairs({ "x", "o" }) do
			vim.api.nvim_set_keymap(
				mode,
				"i" .. char,
				string.format(":<C-u>normal! T%svt%s<CR>", char, char, char),
				{ noremap = true, silent = true, desc = string.format(desc, char) }
			)
			vim.api.nvim_set_keymap(
				mode,
				"a" .. char,
				string.format(":<C-u>normal! F%svf%s<CR>", char, char, char),
				{ noremap = true, silent = true, desc = string.format(desc, char) }
			)
		end
	end
	local desc = "allow to select or operate between character %s even if cursor is not inside current word"

	for _, char in ipairs(chars) do
		for _, mode in ipairs({ "x", "o" }) do
			vim.api.nvim_set_keymap(
				mode,
				"i" .. char,
				string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char),
				{ noremap = true, silent = true, desc = string.format(desc, char) }
			)
			vim.api.nvim_set_keymap(
				mode,
				"a" .. char,
				string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char),
				{ noremap = true, silent = true, desc = string.format(desc, char) }
			)
		end
	end
end

M.select_indent = function(around)
	local start_indent = vim.fn.indent(vim.fn.line("."))
	local blank_line_pattern = "^%s*$"
	local is_prev_blank_line = function(line)
		return string.match(line, blank_line_pattern)
	end

	if string.match(vim.fn.line("."), blank_line_pattern) then
		return
	end
	if vim.v.count > 0 then
		-- shiftwidth stands for the number of columns needed for one level
		-- of indentation for the current buffer
		start_indent = start_indent - vim.o.shiftwidth * (vim.v.count - 1)
		if start_indent < 0 then
			start_indent = 0
		end
	end

	local prev_line = vim.fn.line(".") - 1

	-- move up till we are at the top of the buffer
	-- or we till the indentation is less than the starting one
	while prev_line > 0 and (is_prev_blank_line(prev_line) or vim.fn.indent(prev_line) >= start_indent) do
		-- move up
		vim.cmd("-")
		prev_line = vim.fn.line(".") - 1
	end
	if around then
		vim.cmd("-")
	end

	-- begin visual mode
	vim.cmd("normal! 0V")

	local last_line = vim.fn.line("$")
	local next_line = vim.fn.line(".") + 1

	-- move down till we back to our starting point
	-- or to the bottom of the buffer
	while next_line <= last_line and (is_prev_blank_line(next_line) or vim.fn.indent(next_line) >= start_indent) do
		vim.cmd("+")
		next_line = vim.fn.line(".") + 1
	end
	if around then
		vim.cmd("+")
	end
end

M.indent_text_objects = function()
	vim.keymap.set({ "x", "o" }, "ii", function()
		M.select_indent()
	end, { remap = false, silent = true, desc = "select or operate inside block of same indentation" })
	vim.keymap.set({ "x", "o" }, "ai", function()
		M.select_indent(true)
	end, { remap = false, silent = true, desc = "select or operate around block of same indentation" })
end

M.basic_text_objects()
M.indent_text_objects()

return M
