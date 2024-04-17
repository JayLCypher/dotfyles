return {
	"AckslD/nvim-trevJ.lua",
	event = "BufEnter",

	keys = {
		{ "K", function() require("trevj").format_at_cursor() end, desc = "which_key_ignore", silent = true },
	},
}
