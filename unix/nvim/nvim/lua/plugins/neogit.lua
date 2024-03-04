return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		"nvim-telescope/telescope.nvim", -- optional
	},
	keys = {
		{ "<leader>g", function() require("neogit").open() end, desc = "[Neogit] open" },
	},
	opts = {},
}
