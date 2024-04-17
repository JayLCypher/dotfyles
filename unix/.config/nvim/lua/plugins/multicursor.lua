return {
	"brenton-leighton/multiple-cursors.nvim",
	version = "*", -- Use the latest tagged version
	opts = {}, -- This causes the plugin setup function to be called
	keys = {
		{ "<C-A-Down>", "<Cmd>MultipleCursorsAddDown<CR>", desc = "[MultiCursor] Add down", mode = { "n", "i" } },
		{ "<C-A-Up>", "<Cmd>MultipleCursorsAddUp<CR>", desc = "[MultiCursor] Add up", mode = { "n", "i" } },
		{ "<C-A-j>", "<Cmd>MultipleCursorsAddDown<CR>", desc = "[MultiCursor] Add down", mode = { "n", "i" } },
		{ "<C-A-k>", "<Cmd>MultipleCursorsAddUp<CR>", desc = "[MultiCursor] Add up", mode = { "n", "i" } },
		{ "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", desc = "[MultiCursor] Add/Remove", mode = { "n", "i" } },
		{ "<C-L>", "<Cmd>MultipleCursorsAddBySearch<CR>", desc = "[MultiCursor] Add by search", mode = { "n", "x" } },
		{ "<C-A-L>", "<Cmd>MultipleCursorsAddBySearchV<CR>", desc = "[MultiCursor] Add by previous HL", mode = { "n", "x" } },
	},
}
