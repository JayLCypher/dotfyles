return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	priority = 999,
	event = "VimEnter",
	config = function() require("alpha").setup(require("alpha.themes.theta").config) end,
	keys = {
		{ "<leader>a", "<CMD> Alpha <CR>", desc = "[Alpha] Open Dashboard" },
	},
}
