-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
	"dockerls",
	"sqlls",
	"marksman",
	"gopls",
	"jsonls",
	"rust_analyzer",
})

lsp.configure("lua-language-server", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	["<Tab>"] = nil,
	["<S-Tab>"] = nil,
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- base config
local function config(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, { desc = "[G]o [D]efinition" })
	vim.keymap.set("n", "fmt", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "[F]or[M]a[T]" })
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, { desc = "[V]iew [D]iagnostic" })
	vim.keymap.set("n", "$d", function()
		vim.diagnostic.goto_next()
	end, { desc = "Next occurrence" })
	vim.keymap.set("n", "ùd", function()
		vim.diagnostic.goto_prev()
	end, { desc = "Previous occurence" })
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, { desc = "[V]iew [C]ode [A]ction" })
	vim.keymap.set("n", "<leader>vco", function()
		vim.lsp.buf.code_action({
			filter = function(code_action)
				if not code_action or not code_action.data then
					return false
				end

				local data = code_action.data.id
				return string.sub(data, #data - 1, #data) == ":0"
			end,
			apply = true,
		})
	end, { desc = "[V]iew [C]ode actions [O]thers" })
	vim.keymap.set("n", "<leader>vcr", function()
		vim.lsp.buf.references()
	end, { desc = "[V]iew [C]ode [R]eferences" })
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, { desc = "[V]iew [R]e[N]ame" })
end

local function merge_config(_config, baseConfig)
	local config = {
		on_attach = baseConfig,
	}
	return vim.tbl_deep_extend("force", config, _config or {})
end

lsp.on_attach(config)

-- then for each specific language, we overload the config
require("lspconfig").phpactor.setup(merge_config({

	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
	},

	on_attach = function()
		vim.keymap.set("n", "gd", ":PhpactorGotoDefinition", { desc = "PHP: [G]oto[D]efinition" })
		vim.keymap.set("n", "gdv", ":PhpactorGotoDefinition vsplit", { desc = "PHP: [G]oto[D]efinition [v]split" })
		vim.keymap.set("n", "<leader>i", ":PhpactorImportClass", { desc = "PHP: [I]mportClass" })
		vim.keymap.set("n", "<leader>cf", ":PhpactorCopyFile", { desc = "PHP: [C]opy[F]ile" })
		vim.keymap.set("n", "<leader>cc", ":PhpactorCopyClassName", { desc = "PHP: [C]opy[C]lassName" })
		-- find usages in quifix list
		vim.keymap.set("n", "<leader>fr", ":PhpactorFindReferences", { desc = "PHP: [F]ind[R]eferences" })
		-- jump to parent class
		vim.keymap.set("n", "<leader>nv", ":PhpactorNavigate", { desc = "PHP: [N]a[v]igate" })
		vim.keymap.set("n", "<leader>im", ":PhpactorGotoImplementations<CR>", { desc = "PHP: Go to [Im]plementations" })
		-- open context menu
		vim.keymap.set("n", "<leader>cm", ":PhpactorContextMenu<CR>", { desc = "PHP: Open [C]ontext[M]enu" })
	end,

	filetypes = { "php", "cucumber" },
}, config))

require("lspconfig").gopls.setup(merge_config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}, config))

lsp.setup()
