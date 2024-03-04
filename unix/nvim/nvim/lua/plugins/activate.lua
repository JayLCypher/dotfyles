return {
	"roobert/activate.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	event = "VimEnter",
	keys = {
		{
			"<leader>P",
			function() require("activate").list_plugins() end,
			desc = "[Activate] plugins",
		},
	},
}
