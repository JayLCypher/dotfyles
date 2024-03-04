-- [[ Setting options ]]

-- Treat .h files as .c files instead of .cpp
vim.g.c_syntax_for_h = true

vim.o.background = "dark" -- always dark.

-- Enable break indent
vim.o.breakindent = true

-- Fuck spaces, do tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smarttab = true

-- Make line numbers and relative numbers default
vim.opt.ruler = true
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true

vim.opt.scrolloff = 8

-- Do I need this with lualine?
vim.opt.showmode = false

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Take ThePrimagen's advice, disable line wraps.
vim.opt.wrap = false

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Backups and Undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.opt.undofile = true

-- ListChars, one of the things I like from VSCode :)
vim.opt.list = true
--tab = "🡢 ",
vim.opt.listchars = {
	space = "•",
	tab = "➞ ",
}

-- Incremental search allowed.
vim.opt.incsearch = true
-- Incremental query replace
vim.opt.inccommand = "split"

-- [[ Highlight on yank ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})
-- [[ Function Maps ]]
-- Makes the nice | line on errors n shit.
vim.fn.sign_define("DiagnosticSignError", { text = " ┃", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ┃", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ┃", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ┃", texthl = "DiagnosticSignHint" })
