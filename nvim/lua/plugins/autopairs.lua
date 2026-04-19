return {
	-- auto close parenthesis
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		-- Setup nvim-cmp.
		local status_ok, npairs = pcall(require, "nvim-autopairs")
		if not status_ok then
			return
		end

		npairs.setup({
			-- we can use treesitter to check for a pair
			check_ts = true,
			ts_config = {
				lua = { "string", "source" }, -- it will not add a pair on that treesitter node
				javascript = { "string", "template_string" },
				java = false, -- don't check treesitter on java
			},
			-- dont add pair on telescope
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel", -- see :hi PmenuSel
				highlight_grey = "LineNr",
			},
		})
	end,
}
