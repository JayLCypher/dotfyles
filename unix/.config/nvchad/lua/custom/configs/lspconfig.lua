local configs = require("plugins.configs.lspconfig")

local on_attach = function(client, bufnr)
	local utils = require "core.utils"
	local conf = utils.load_config().ui.lsp
	-- semanticTokens
	if not conf.semantic_tokens and client.supports_method "textDocument/semanticTokens" then
		client.server_capabilities.semanticTokensProvider = nil
	end

	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	utils.load_mappings("lspconfig", { buffer = bufnr })
end

-- local on_attach = configs.on_attach
local capabilities = configs.capabilities

dofile(vim.g.base46_cache .. "lsp")

require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

local lspconfig = require "lspconfig"
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(_, bufnr)
	lsp_zero.on_attach = on_attach
	lsp_zero.capabilities = capabilities
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				lsp_zero.default_setup,
			})
		end,
		serve_d = function()
			lspconfig.serve_d.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					serve_d = {
						"--provide implement-snippets task-runner tasks-current",
						"d.enableLinting",
						"d.enableDubLinting",
						"d.enableStaticLinting",
						"d.enableAutoComplete",
					},
				},
				lsp_zero.default_setup,
			})
		end,
		clangd = function()
			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				lsp_zero.default_setup,
			})
		end,
		ocamllsp = function()
			lspconfig.ocamllsp.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				lsp_zero.default_setup,
			})
		end,
	}
})

-- lspconfig.ccls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	lsp_zero.default_setup,
-- 	args = "--index=" .. vim.loop.cwd(),
-- 	init_options = {
-- 		index = {
-- 			threads = 0,
-- 		},
-- 		clang = {
-- 			extraArgs = {
-- 				"-Wall",
-- 				"-Wextra",
-- 				"-Wpedantic",
-- 				"-Wshadow",
-- 				"-Wswitch",
-- 			},
-- 			excludeArgs = { "-frounding-math"}, },
-- 	},
-- })


local nvimlint = require("lint")
nvimlint.linters.goblint = {
	cmd = "goblint",
	stdin = true,
	append_fname = true,
	args = {},
	stream = nil,
	ignore_exitcode = false,
	env = nil,
}
nvimlint.linters.cpplint.args = {
	"--quiet",
	"--linelength=150",
	"--filter=-legal/copyright,-whitespace/tab,-whitespace/comments,-readability/braces,-whitespace/newline,",
}
nvimlint.linters.cppcheck.args = {
	"--cppcheck-build-dir=/tmp/cppcheck",
}
nvimlint.linters.clangtidy.args = {

}
nvimlint.linters.selene.args = {
	"--config ---\nglobal:\n\tvim",
}
nvimlint.linters_by_ft = {
	c = {
		"cppcheck",
		"cpplint",
	},
	cpp = {
		"cppcheck",
		"cpplint",
		--"clangtidy",
	},
	lua = {
		"selene",
	},
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged", "FocusGained" }, {
	group = lint_augroup,
	callback = function() vim.defer_fn(nvimlint.try_lint, 1) end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = lint_augroup,
	callback = function() nvimlint.try_lint() end,
})

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		c = { "clang_format", },
		cpp = { "clang_format", },
		d = { "dfmt" },
		ocaml = { "ocamlformat",  },
		csharp = { "csharpier",  },
		json = { "biome", },
		javascript = { "biome", },
		typescript = { "biome", },
		markdown = { "markdownlint", },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		dfmt = {
			prepend_args = { "--indent_style=tab", "--brace_style=stroustrup", "--keep_line_breaks=true", "--soft_max_line_length=120", "--max_line_length=150" }
		},
		clang_format = {
			prepend_args = {
				"--style={BasedOnStyle: Google, IndentWidth: 4, UseTab: Always, TabWidth: 4, AllowShortIfStatementsOnASingleLine: true, IndentCaseLabels: true}"
			}
		}
	}
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

