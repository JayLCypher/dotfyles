return {
	"lukas-reineke/indent-blankline.nvim",
	-- event = "LazyFile",
	main = "ibl",
	config = function()
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
		end)
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "CursorColumnRed", { bg = "#E06C75" })
			vim.api.nvim_set_hl(0, "CursorColumnYellow", { bg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "CursorColumnBlue", { bg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "CursorColumnOrange", { bg = "#D19A66" })
			vim.api.nvim_set_hl(0, "CursorColumnGreen", { bg = "#98C379" })
			vim.api.nvim_set_hl(0, "CursorColumnViolet", { bg = "#C678DD" })
			vim.api.nvim_set_hl(0, "CursorColumnCyan", { bg = "#56B6C2" })
		end)

		local rainbow_colors = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		}

		local highlight_colors = {
			"CursorColumnRed",
			"CursorColumnYellow",
			"CursorColumnBlue",
			"CursorColumnOrange",
			"CursorColumnGreen",
			"CursorColumnViolet",
			"CursorColumnCyan",
		}

		require("ibl").setup {
			-- The indentation guide, such as | or -> or whatever.
			indent = {
				highlight = rainbow_colors,
				char = "│",
				tab_char = "│",
			},
			whitespace = {
				--highlight = highlight_colors,
				remove_blankline_trail = false,
			},
			scope = {
				enabled = false,
				highlight = "Whitespace",
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		}
	end,
}
