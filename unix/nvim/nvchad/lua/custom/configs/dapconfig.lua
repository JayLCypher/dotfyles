
local mason_dap = require("mason-nvim-dap")
mason_dap.setup({
	handlers = {
		function(config)
			--- No handlers get put here.
			mason_dap.default_setup(config)
		end,
		python = function(config)
			config.adapters = {
				type = "executable",
				command = "/usr/bin/python3",
				args = {
					"-m",
					"debugpy.adapter",
				},
			}
			mason_dap.default_setup(config) -- don't forget this!
		end,
		codelldb = function(config)
			config.adapters = {
				type = 'server',
				port = '${port}',
				executable = {
					command = vim.fn.exepath('codelldb'),
					args = { '--port', '${port}' },
				},
			}
		end,
	},
})

local gdb = {
	name = "Launch file with GDB",
	type = "gdb",
	request = "launch",
	program = function ()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = "${workspaceFolder}",
	runInTerminal = false,
	stopOnEntry = true,
	args = {},
}

local lldb = {
	name = "Launch file with LLDB",
	type = "lldb",
	request = "launch",
	program = function ()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = true,
	runInTerminal = false,
	args = {},
}

local dap = require("dap")
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" },
}
dap.configurations.c = {
	gdb,
	-- lldb,
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

local overseer = require('overseer')
overseer.setup()
require("dap.ext.vscode").json_decode = overseer.json.decode
