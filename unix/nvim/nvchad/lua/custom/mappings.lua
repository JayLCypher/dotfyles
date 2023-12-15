local M = {}

M.disabled = {
	n = {
		["<leader>fm"] = "",
	}
}

M.bindings = {
	n = {
		["<leader>tt"] = {
			function() require("base46").toggle_transparency() end,
			"Toggle transparency",
		},
		["J"] = { "mzJ`z" },
		["<C-d>"] = { "<C-d>zz" },
		["<C-u>"] = { "<C-u>zz" },
		["n"] = { "nzzzv" },
		["N"] = { "Nzzzv" },
		["<leader>y"] = { "\"+y", "Yank to system" },
		["<leader>Y"] = { "\"+Y", "Yank EoL to system", },
		["tfs"] = { function() if vim.g.neovide then vim.o.guifont = "Source Code Pro:h14" end end, },
		["tfm"] = { function() if vim.g.neovide then vim.o.guifont = "Monocraft Nerd Font:h14" end end, },
	},
	i = {
		["<S-tab>"] = { "<cmd> < <CR>", "Deindent line", },
		["<A-j>"] = { "<cmd>m .+1<CR>", "Move line up 1", },
		["<A-k>"] = { "<cmd>m .-2<CR>", "Move line down 1", },
	},
	v = {
		["J"] = { "<cmd>m '>+1<CR>gv=gv", "Move selection up", },
		["K"] = { "<cmd>m '<-2<CR>gv=gv", "Move selection down", },
		["<leader>y"] = { "\"+y", "Yank to system" },
	},
	x = {
		["<leader>p"] = { "\"_dP", "Void Paste" },
	}
}

M.zenmode = {
	n = { ["<leader>z"] = { "<cmd> ZenMode <CR>", "Toggle Zen Mode" } },
}

M.dap = {
	n = {
		["<leader>db"] = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint", },
		["<F5>"] = { function() require("dap").continue() end, "Dap Continue", },
		["<C-S-F5>"] = { function() require("dap").restart() end, "Dap Restart", },
		["<F10>"] = { function() require("dap").step_over() end, "Dap Continue", },
		["<F11>"] = { function() require("dap").step_into() end, "Dap Step-Into", },
		["<S-F11>"] = { function() require("dap").step_out() end, "Dap Step-Out", },
	},
}

M.trouble = {
	n = {
		["<leader>tx"] = { function() require("trouble").toggle() end, "Toggle Trouble", },
		["<leader>tw"] = { function() require("trouble").toggle("workspace_diagnostics") end, "Toggle Workspace Diagnostics", },
		["<leader>td"] = { function() require("trouble").toggle("document_diagnostics") end, "Toggle Document Diagnostics", },
		["<leader>tq"] = { function() require("trouble").toggle("quickfix") end, "Toggle Quickfix", },
		["<leader>tl"] = { function() require("trouble").toggle("loclist") end, "Toggle Location list", },
		["gR"] = { function () require("trouble").toggle("lsp_references") end, "Toggle LSP References", },
	},
}

M.multicursor = {
	n = {
		["<Leader>m"] = {'<cmd>MCstart<cr>', 'Create a selection for selected text or word under the cursor', },
	},
	v = {
		["<Leader>m"] = {'<cmd>MCstart<cr>', 'Create a selection for selected text or word under the cursor', },
	},
}

return M
