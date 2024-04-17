return {
	"backdround/global-note.nvim",
	keys = {
		{ "<leader>G", function() require("global-note").toggle_note() end, desc = "[GlobalNote] toggle" },
	},
	opts = {},
	config = function(_)
		local global_note = require("global-note")
		global_note.setup()
	end,
}
