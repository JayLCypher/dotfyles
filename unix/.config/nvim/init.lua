--vim.notify("NVIM: Initializing!")

-- Set <space> as the leader key, for more information see `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

M = {}

-- Settings & Options
--vim.notify("NVIM: Settings/Options begin")
require("settings")
--vim.notify("NVIM: Settings/Options end")

-- Plugins
--vim.notify("NVIM: Plugins begin")
require("plugin")
--vim.notify("NVIM: Plugins end")

-- Key mappings
--vim.notify("NVIM: Mappings begin")
require("mappings")
--vim.notify("NVIM: Mappings end")

--vim.notify("NVIM: Initialization complete.")
