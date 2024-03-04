-- To ignore a keybind, put the desc to "which_key_ignore"
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register {
				["<leader>B"] = { name = "[B]uffer", _ = "which_key_ignore" },
				["<leader>b"] = { name = "[b]ug", _ = "which_key_ignore" },
				["<leader>c"] = { name = "[c]ode", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[f]ind", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[t]rouble", _ = "which_key_ignore" },
			}
		end,
	},
}
