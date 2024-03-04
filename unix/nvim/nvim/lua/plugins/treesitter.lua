return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
		},
		config = function(_, _)
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "bash", "c", "lua", "markdown", "markdown_inline", "vim", "vimdoc" },
				auto_install = true, -- Autoinstall languages that are not installed
				highlight = { enable = true },
				indent = { enable = true },
				refactor = {
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
					},
					highlight_current_scope = { enable = true },
					smart_rename = {
						enable = true,
						-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
						keymaps = {
							smart_rename = "gm",
						},
					},
				},
				navigation = {
					enable = true,
					-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
					keymaps = false,
				},
			}
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
		config = function(_, opts)
			local autotag = require("nvim-ts-autotag")
			autotag.setup(opts)
			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				underline = true,
				virtual_text = {
					spacing = 5,
					severity_limit = "Warning",
				},
				update_in_insert = true,
			})
		end,
	},
}
