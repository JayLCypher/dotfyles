return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			function() require("conform").format { async = true, lsp_fallback = true } end,
			mode = "",
			desc = "[Conform] Format",
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" -- If you want the formatexpr, here is the place to set it
	end,
	config = function()
		local conform = require("conform")
		conform.setup {
			formatters_by_ft = {
				lua = {
					"stylua",
				},
				c = {
					--"clang_format",
				},
				h = conform.formatters_by_ft.c,
				cpp = {
					"clang_format",
				},
				html = {
					--"prettierd",
				},
				css = {
					"prettierd",
				},
				scss = conform.formatters_by_ft.css,
				less = conform.formatters_by_ft.css,
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0, UseTab: Always, TabWidth: 4, AllowShortIfStatementsOnASingleLine: true, IndentCaseLabels: true}",
					},
				},
				dfmt = {
					prepend_args = {
						"--indent_style=tab",
						"--brace_style=stroustrup",
						"--keep_line_breaks=true",
						"--soft_max_line_length=120",
						"--max_line_length=150",
					},
				},
				gofmt = {
					prepend_args = { "-s", "-w" },
				},
			},
		}
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args) conform.format { bufnr = args.buf } end,
		})
	end,
}
