return {
	{ "lukas-reineke/virt-column.nvim", event = "BufEnter", opts = {} },
	{
		"m4xshen/smartcolumn.nvim",
		event = "BufEnter",
		opts = {
			colorcolumn = "124",
			disabled_filetypes = { "NvimTree", "lazy", "mason", "help", "checkhealth", "lspinfo", "noice", "Trouble", "fish", "zsh" },
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		event = "BufEnter",
		dependencies = {
			"mfussenegger/nvim-dap",
			"lewis6991/gitsigns.nvim",
		},
		config = function() require("statuscol").setup {} end,
	},
}
