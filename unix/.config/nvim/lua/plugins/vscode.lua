return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local vscode = require("vscode")
			local c = require("vscode.colors").get_colors()
			vscode.setup {
				style = "dark",
				transparent = false, -- Enable transparent background
				italic_comments = true, -- Enable italic comment
				underline_links = true, -- Underline `@markup.link.*` variants
				disable_nvimtree_bg = true, -- Disable nvim-tree background color

				-- Override colors (see ./lua/vscode/colors.lua)
				color_overrides = {
					--vscLineNumber = "#FFFFFF",
				},

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				},
			}
			vscode.load()
		end,
	},
	{
		"tomasiser/vim-code-dark",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function() vim.cmd([[colorscheme codedark]]) end,
	},
	{
		"kosayoda/nvim-lightbulb",
		opts = { autocmd = { enabled = true } },
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = false,
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"vidocqh/auto-indent.nvim",
		enabled = false,
		opts = {},
	},
}
