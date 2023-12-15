---@class ChadrcConfig
local M = {}

M.ui = {
	theme = 'vscode_dark',
	statusline = {
		theme = "vscode_colored",
	},
	hl_override = {
		["Comment"] = { fg = "#6A9955" },
		["Structure"] = { fg = "green1" },
		["Include"] = { fg = "#c586c0" },
		["Macro"] = { fg = "blue" },
		["Identifier"] = { fg = "#9cdcfe" },
	},
}
M.ui.extended_integrations = {
	'trouble',
	'dap',
	'rainbowdelimiters',
	'todo',
	'notify',
	'navic',
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
