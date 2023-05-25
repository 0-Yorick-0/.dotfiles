-- autompletion with lsp
return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		}, -- Optional
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "hrsh7th/cmp-buffer" }, -- Optional
		{ "hrsh7th/cmp-path" }, -- Optional
		{ "saadparwaiz1/cmp_luasnip" }, -- Optional
		{ "hrsh7th/cmp-nvim-lua" }, -- Optional
		{ "honza/vim-snippets" },

		-- Snippets
		{
			"L3MON4D3/LuaSnip", -- Required
			-- load snippets. See https://github.com/honza/vim-snippets/blob/master/snippets/php.snippets
			-- for list of snippets shortcuts
			config = function()
				-- required to enable snippets from honza/vim-snippets
				require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading
			end,
			build = "make install_jsregexp",
		},
		{ "rafamadriz/friendly-snippets" }, -- Optional
	},
	config = function()
		-- Learn the keybindings, see :help lsp-zero-keybindings
		-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
		local lsp = require("lsp-zero").preset({})

		lsp.ensure_installed({
			"tsserver",
			"eslint",
			"lua_ls",
			"dockerls",
			"sqlls",
			"marksman",
			"gopls",
			"jsonls",
			"phpactor",
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

		-- base config
		local on_attach = function(client, bufnr)
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

		lsp.on_attach(on_attach)

		-- then for each specific language, we overload the config
		local lspconfig = require("lspconfig")
		lspconfig.phpactor.setup({
			init_options = {
				["language_server_phpstan.enabled"] = false,
				["language_server_psalm.enabled"] = false,
			},
			on_attach = function()
				print("php")
				vim.keymap.set("n", "gd", ":PhpactorGotoDefinition<CR>", { desc = "PHP: [G]oto[D]efinition" })
				vim.keymap.set(
					"n",
					"gdv",
					":PhpactorGotoDefinition vsplit<CR>",
					{ desc = "PHP: [G]oto[D]efinition [v]split" }
				)
				vim.keymap.set("n", "<leader>i", ":PhpactorImportClass<CR>", { desc = "PHP: [I]mportClass" })
				vim.keymap.set("n", "<leader>cf", ":PhpactorCopyFile<CR>", { desc = "PHP: [C]opy[F]ile" })
				vim.keymap.set("n", "<leader>cc", ":PhpactorCopyClassName<CR>", { desc = "PHP: [C]opy[C]lassName" })
				-- find usages in quifix list
				vim.keymap.set("n", "<leader>fr", ":PhpactorFindReferences<CR>", { desc = "PHP: [F]ind[R]eferences" })
				-- jump to parent class
				vim.keymap.set("n", "<leader>nv", ":PhpactorNavigate<CR>", { desc = "PHP: [N]a[v]igate" })
				vim.keymap.set(
					"n",
					"<leader>im",
					":PhpactorGotoImplementations<CR>",
					{ desc = "PHP: Go to [Im]plementations" }
				)
				-- open context menu
				vim.keymap.set("n", "<leader>cm", ":PhpactorContextMenu<CR>", { desc = "PHP: Open [C]ontext[M]enu" })
				vim.keymap.set("n", "<leader>tr", ":PhpactorTransform<CR>", { desc = "PHP: Open [Tr]ansform" })
			end,
			filetypes = { "php", "cucumber" },
		})

		lspconfig.gopls.setup({
			cmd = { "gopls", "serve" },
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
				},
			},
		})

		lsp.setup()

		local cmp = require("cmp")
		local cmp_action = require("lsp-zero").cmp_action()
		local kind_icons = {
			Array = " ",
			Boolean = " ",
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Copilot = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Namespace = " ",
			Null = " ",
			Number = " ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			String = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		}

		-- ls = require("luasnip")
		-- ls.filetype_extend("all", { "_" })

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				-- Navigate between snippet placeholder
				["<C-f>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Tab>"] = nil,
				["<S-Tab>"] = nil,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
			formatting = {
				fields = { "abbr", "menu", "kind" },
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
					-- This concatenates the icons with the name of the item kind
					vim_item.menu = ({
						luasnip = "LuaSnip",
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})
	end,
}
