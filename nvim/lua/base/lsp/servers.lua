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
	-- LSP servers and clients communicate which features they support through
	-- "capabilities".
	local capabilities = lsp_utils.capabilities()

	-- get all the servers that are available through mason-lspconfig
	local have_mason, mlsp = pcall(require, "mason-lspconfig")
	local all_mslsp_servers = {}
	if have_mason then
		all_mslsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
	end

	local mason_exclude = {} ---@type string[]
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			-- run manual setup if mason=false or if this is a server that cannot
			-- be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(all_mslsp_servers, server) then
				vim.lsp.config(server, server_opts)
				vim.lsp.enable(server)
			else
				M.setupServer(servers, server, server_opts, opts)
				-- Whether installed servers should automatically be
				-- enabled via vim.lsp.enable()
				mason_exclude[#mason_exclude + 1] = server
			end
		end
	end
	---@type boolean | string[] | { exclude: string[] }
	mlsp.setup({ exclude = mason_exclude })
end

-- e.g. in ~/.dotfiles/nvim/lua/pde/go.lua
-- opts = {
--  ....
--     servers = { <- servers
--         gopls = { <- current_server
--             settings = { <- server_config
--     setup = {
--         gopls = function(_,_)
function M.setupServer(servers, current_server, server_config, opts)
	local server_capabilities
	-- opts[current_server].capabilities, if defined
	-- if server_config and server_config.capabilities then
	-- 	server_capabilities = require("blink.cmp").get_lsp_capabilities(server_config.server_capabilities)
	-- else
	-- 	server_capabilities = require("blink.cmp").get_lsp_capabilities()
	-- end
	-- -- With blink.cmp, Neovim has more capabilities which are communicated
	-- -- to the LSP servers.
	-- local server_opts = vim.tbl_deep_extend("force", {
	-- 	capabilities = server_capabilities,
	-- }, servers[current_server] or {})

	if opts.setup[current_server] then
		if opts.setup[current_server](current_server, server_opts) then
			return
		end
		--Specify * to use this function as a fallback for any server
	elseif opts.setup["*"] then
		if opts.setup["*"](current_server, server_opts) then
			return
		end
	end
end

return M
