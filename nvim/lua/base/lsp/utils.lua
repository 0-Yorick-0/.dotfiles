local M = {}

function M.capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
	return vim.tbl_deep_extend("force", {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	}, capabilities)
end

-- called from nvim/lua/base/lsp/server.lua
-- this will be called to attach format and keymap handlers
-- to each lsp client
-- but also in nvim/lua/pde/*.lua, in opts.setup to attach language specific handlers
function M.on_attach(on_attach)
	-- every time we attach an LSP Client
	vim.api.nvim_create_autocmd("LspAttach", {
		-- this callback we'll be attached
		callback = function(args)
			local bufnr = args.buf
			---@type vim.lsp.Client
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			on_attach(client, bufnr)
		end,
	})
end

local diagnostics_active = true

function M.show_diagnostics()
	return diagnostics_active
end

function M.toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end

function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

return M
