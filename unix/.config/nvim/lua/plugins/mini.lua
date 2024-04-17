return {
	{
		"echasnovski/mini.nvim",
		event = "BufEnter",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function(_, _)
			require("mini.ai").setup { n_lines = 500 }
			require("mini.align").setup()
			require("mini.comment").setup {
				mappings = {
					comment_line = "gC",
				},
			}
			require("mini.cursorword").setup()
			local map = require("mini.map")
			map.setup {
				integrations = {
					map.gen_integration.builtin_search(),
					map.gen_integration.gitsigns(),
					map.gen_integration.diagnostic(),
				},
			}
			require("mini.move").setup {
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt + hjkl.
					left = "<S-Tab>",
					right = "<Tab>",
					down = "<A-j>",
					up = "<A-k>",

					-- Move current line in Normal mode
					line_left = "<A-h>",
					line_right = "<A-l>",
					line_down = "<A-j>",
					line_up = "<A-k>",
				},
			}
			require("mini.pairs").setup {
				modes = { insert = true, command = true, terminal = false },
			}
			require("mini.splitjoin").setup()
		end,
	},
}
