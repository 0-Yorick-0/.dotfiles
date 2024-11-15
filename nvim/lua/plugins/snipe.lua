return {

	"leath-dub/snipe.nvim",
	keys = {
		{
			-- D to delete buffer
			-- V to split vertically
			-- J for next page
			-- K for previous page
			"gb",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	},
	opts = {},
}
