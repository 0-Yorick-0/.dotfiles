local M = {}

local lsp_utils = require("base.lsp.utils")

local function lsp_init()
	-- LSP handlers configuration
	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},

		diagnostic = {
			virtual_text = {
				severity = {
					min = vim.diagnostic.severity.WARN,
				},
			},
			underline = false,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	}

	-- Diagnostic configuration
	vim.diagnostic.config(config.diagnostic)
end

-- called from nvim/lua/base/lsp/init.lua
-- with nvim-lspconfig::config
-- this makes it possible to configure each server individually
function M.setup(_, opts)
	lsp_utils.on_attach(function(client, bufnr)
		require("base.lsp.format").on_attach(client, bufnr)
		require("base.lsp.keymaps").on_attach(client, bufnr)
	end)

	lsp_init() -- diagnostics, handlers
	-- all servers are already loaded in config.init, which is called in
	-- config.lazy.lua
	local servers = opts.servers
	local capabilities = lsp_utils.capabilities()

	local function setup(server, server_config)
		local server_capabilities
		if server_config and server_config.capabilities then
			server_capabilities = require("blink.cmp").get_lsp_capabilities(server_config.server_capabilities)
		else
			server_capabilities = require("blink.cmp").get_lsp_capabilities()
		end

		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = server_capabilities,
		}, servers[server] or {})

		if opts.setup[server] then
			if opts.setup[server](server, server_opts) then
				return
			end
		elseif opts.setup["*"] then
			if opts.setup["*"](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	-- get all the servers that are available through mason-lspconfig
	local have_mason, mlsp = pcall(require, "mason-lspconfig")
	local all_mslp_servers = {}
	if have_mason then
		all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
	end

	local ensure_installed = {} ---@type string[]
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
				setup(server, server_opts)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end

	if have_mason then
		mlsp.setup({ ensure_installed = ensure_installed })
		mlsp.setup_handlers({ setup })
	end
end

return M
