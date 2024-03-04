return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		{ "<leader>tx", function() require("trouble").toggle() end, desc = "[Trouble] Toggle" },
		{ "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "[Trouble] Toggle Workspace Diagnostics" },
		{ "<leader>td", function() require("trouble").toggle("document_diagnostics") end, desc = "[Trouble] Toggle Document Diagnostics" },
		{ "<leader>tq", function() require("trouble").toggle("quickfix") end, desc = "[Trouble] Toggle Quickfix List" },
		{ "<leader>tl", function() require("trouble").toggle("loclist") end, desc = "[Trouble] Toggle Location List" },
		{ "gR", function() require("trouble").toggle("lsp_references") end, desc = "[Trouble] Toggle LSP References" },
	},
}
