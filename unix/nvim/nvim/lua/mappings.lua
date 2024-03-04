-- [[ Basic Keymaps ]]

local wk_ignore = { desc = "which_key_ignore", silent = true }

-- NORMAL MODE
-- Keymaps for better default experience
vim.keymap.set("n", "Q", "<Nop>", wk_ignore)
vim.keymap.set("n", "<Esc>", "<cmd> nohlsearch <CR>", wk_ignore)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", wk_ignore)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File system
vim.keymap.set("n", "<leader>n", "<cmd>tabnew<CR>", wk_ignore)

-- Navigation between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", wk_ignore)
vim.keymap.set("n", "<C-l>", "<C-w>l", wk_ignore)
vim.keymap.set("n", "<C-j>", "<C-w>j", wk_ignore)
vim.keymap.set("n", "<C-k>", "<C-w>k", wk_ignore)

-- Navigation cursor stays center
vim.keymap.set("n", "<C-d>", "<C-d>zz", wk_ignore)
vim.keymap.set("n", "<C-u>", "<C-u>zz", wk_ignore)

-- Prepend Line J but cursor remains.
vim.keymap.set("n", "J", "mzJ`z", wk_ignore)

-- Search terms cursor stay centered.
vim.keymap.set("n", "n", "nzzzv", wk_ignore)
vim.keymap.set("n", "N", "Nzzzv", wk_ignore)

-- Clipboard copy
vim.keymap.set({ "n", "i" }, "<C-S-v>", '"+p', wk_ignore) -- [Prime] paste from system clipboard
vim.keymap.set("n", "<leader>Y", '"+Y', wk_ignore) -- [Prime] copy rest to system clipboard

-- Void delete
vim.keymap.set("n", "<leader>d", '"_d', { desc = "[Prime] void delete", silent = true }) -- SANITY!

-- Modern save
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "(Modern) Save", silent = true })
vim.keymap.set("n", "<C-S>", "<cmd>noa w<CR>", { desc = "NoAutocmd Save", silent = true })

-- Substitute word command
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "[Prime] substitute cursor word in file", silent = true })

-- INSERT MODE
-- Line navigation in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", wk_ignore)
vim.keymap.set("i", "<C-l>", "<Right>", wk_ignore)
vim.keymap.set("i", "<C-j>", "<Down>", wk_ignore)
vim.keymap.set("i", "<C-k>", "<Up>", wk_ignore)

-- File navigation in insert mode
vim.keymap.set("i", "<C-B>", "gg", wk_ignore)
vim.keymap.set("i", "<C-E>", "g_", wk_ignore)

vim.keymap.set("i", "<S-Tab>", "<cmd><<CR>", wk_ignore) -- SANITY!

-- VISUAL MODE

-- Indentation
-- vim.keymap.set("x", "<Tab>", ">gv", wk_ignore) -- SANITY!
-- vim.keymap.set("x", "<S-Tab>", "<gv", wk_ignore) -- SANITY!

-- Clipboard copy
--vim.keymap.set("x", "<C-C>", '"+y', wk_ignore) -- [Prime] copy to clipboard

-- Void Paste/delete
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "[Prime] visual void paste", silent = true }) -- SANITY!
vim.keymap.set("x", "<leader>d", '"_d', { desc = "[Prime] visual void paste", silent = true }) -- SANITY!

-- TERMINAL & TMUX MODE

-- Convenience exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
