local function delete_hidden_buffers_excepte_one()
	local current_buffer = vim.api.nvim_get_current_buf()

	for _, buf_handled in ipairs(vim.api.nvim_list_bufs()) do
		if current_buffer ~= buf_handled then
			vim.api.nvim_buf_delete(buf_handled, { force = true })
		end
	end
	print("Deleting hidden buffers")
end

vim.api.nvim_create_user_command("Survivor", delete_hidden_buffers_excepte_one, {})
