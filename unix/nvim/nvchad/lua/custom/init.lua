vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smarttab = true

vim.opt.scrolloff = 8

vim.opt.list = true
vim.opt.listchars = {
	space = '•',
	tab = '🡢 ',
}

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.opt.undofile = true

vim.opt.incsearch = true

if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.1
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5
	--vim.o.guifont = "Source Code Pro:h13"
end

-- Makes the nice | line on errors n shit.
vim.fn.sign_define("DiagnosticSignError", { text = " ┃", texthl = "DiagnosticSignError" , })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ┃", texthl = "DiagnosticSignWarn", })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ┃", texthl = "DiagnosticSignInfo", })
vim.fn.sign_define("DiagnosticSignHint", { text = " ┃", texthl = "DiagnosticSignHint", })

vim.g.c_syntax_for_h = 1
