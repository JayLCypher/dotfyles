return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			lua = {
				"selene",
			},
			markdown = {
				"markdownlint",
				"write_good",
			},
			c = {
				"cpplint",
				"cppcheck",
				--"clangtidy",
			},
			cpp = lint.linters_by_ft.c,
			csharp = {},
			go = {
				"golangcilint",
				-- "nilaway",
				"revive",
				--"staticcheck",
			},
			html = {
				--"htmlhint",
				--"markuplint",
			},
			css = {
				"stylelint",
			},
			scss = lint.linters_by_ft.css,
			less = lint.linters_by_ft.css,
		}

		lint.linters.selene.args = {
			"--no-default-features",
			"--config ---\nglobal:\n\tvim",
		}

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.c", "*.h" },
			callback = function() table.insert(lint.linters.cpplint.args, "-readability/casting") end,
		})
		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = { "*.c", "*.h" },
			callback = function() table.remove(lint.linters.cpplint.args) end,
		})

		lint.linters.cpplint.args = {
			"--quiet",
			"--linelength=150",
			"--filter=-legal/copyright,-whitespace/tab,-whitespace/comments,-whitespace/braces,-readability/braces,-whitespace/newline,-build/header_guard,-build/include_order,-build/include_subdir,-readability/todo,",
		}

		lint.linters.cppcheck.args = {
			"--cppcheck-build-dir=/tmp/cppcheck",
		}

		lint.linters.clangtidy.args = {}

		lint.linters.markdownlint.args = {
			"--config ---\nMD013:\n\tline_length: 150",
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = lint_augroup,
			callback = function() lint.try_lint() end,
		})
		vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged", "FocusGained" }, {
			group = lint_augroup,
			callback = function() vim.defer_fn(lint.try_lint, 1) end,
		})
	end,
}
