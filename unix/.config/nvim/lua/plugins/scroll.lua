return {
	"petertriho/nvim-scrollbar",
	dependencies = {
		{
			"kevinhwang91/nvim-hlslens",
			dependencies = { "kevinhwang91/nvim-ufo" },
		},
		"lewis6991/gitsigns.nvim",
	},
	config = function()
		require("scrollbar").setup()
		require("gitsigns").setup()
		require("scrollbar.handlers.gitsigns").setup()
		require("scrollbar.handlers.search").setup()
	end,
}
