-- [[ Global options ]]
-- Set the C syntax for .h files, since hpp exists.
vim.g.c_syntax_for_h = 1

-- [[ Setting options ]]
-- Pretty colors. NOTE: You should make sure your term supports this
vim.opt.termguicolors = true

-- Make line numbers and relative numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Take ThePrimagen's advice, disable line wraps.
vim.opt.wrap = false

-- Fuck spaces, do tabs.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smarttab = true

-- Scrolloff feature 8 lines above/below. Clamps the cursor to the window.
vim.opt.scrolloff = 8

-- ListChars, according to VSCode, which is a style I like. :)
vim.opt.list = true
vim.opt.listchars = {
	space = '•',
	tab = '🡢 ',
}

-- Backups and Undos according to ThePrimagen
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.opt.undofile = true

-- Incremental search allowed.
vim.opt.incsearch = true

-- [[ Function maps ]]
-- Makes the nice | line on errors n shit.
vim.fn.sign_define("DiagnosticSignError", { text = " ┃", texthl = "DiagnosticSignError" , })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ┃", texthl = "DiagnosticSignWarn", })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ┃", texthl = "DiagnosticSignInfo", })
vim.fn.sign_define("DiagnosticSignHint", { text = " ┃", texthl = "DiagnosticSignHint", })

-- [[ Neovide Settings ]]
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.1
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5
	--vim.o.guifont = "Source Code Pro:h13"
end

