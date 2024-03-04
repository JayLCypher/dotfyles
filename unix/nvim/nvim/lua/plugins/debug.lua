-- debug.lua

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/cmp-dap",
		"rcarriga/nvim-dap-ui", -- Creates a beautiful debugger UI
		"theHamsta/nvim-dap-virtual-text",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		-- 'leoluz/nvim-dap-go',
	},
	keys = {
		{ "<F5>", function() require("dap").continue() end, desc = "[Debug] Start/Continue" },
		{ "<CS-<F5>>", function() require("dap").restart() end, desc = "[Debug] Restart" },
		{ "<S-<F5>>", function() require("dap").terminate() end, desc = "[Debug] Terminate" },
		{ "<F6>", function() require("dap").pause() end, desc = "[Debug] Pause" },
		{ "<F10>", function() require("dap").step_over() end, desc = "[Debug] Step Over" },
		{ "<S-<F10>>", function() require("dap").step_back() end, desc = "[Debug] Step Back" },
		{ "<F11>", function() require("dap").step_into() end, desc = "[Debug] Step Into" },
		{ "<S-<F11>>", function() require("dap").step_out() end, desc = "[Debug] Step Out" },
		{ "<F9>", function() require("dap").toggle_breakpoint() end, desc = "[Debug] Toggle Breakpoint" },
		{ "<leader>bp", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "[Debug] (Conditional) Breakpoint" },
		{ "<leader>be", function() require("dapui").eval() end, "v", desc = "[Debug] Evaluate expression" },
	},
	config = function()
		local dap = require("dap")

		-- Mason-dap
		require("mason-nvim-dap").setup {
			automatic_setup = true, -- Makes a best effort to setup the various debuggers with reasonable debug configurations
			ensure_installed = {},
			handlers = {},
		}

		-- nvim-cmp
		require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
			sources = {
				{ name = "dap" },
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		local dapui = require("dapui")
		dapui.setup {
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				enabled = true,
				element = "repl",
				icons = {
					breakpoint = "🔴",
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "🅱",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			element_mappings = {},
			expand_lines = true,
			force_buffers = true,
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		}

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "[Debug] See last session result." })

		dap.listeners.before.attach["dapui_config"] = dapui.open
		dap.listeners.before.launch["dapui_config"] = dapui.open
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		require("nvim-dap-virtual-text").setup()
		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

		dap.adapters = {
			gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			},
			codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			},
		}

		dap.configurations = {
			c = {
				{
					name = "GDB: Launch file",
					type = "gdb",
					request = "launch",
					program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
				},
				{
					name = "GDB: Launch current file as executable",
					type = "gdb",
					request = "launch",
					program = function() return vim.api.nvim_buf_get_name(0):match("(.+)%..+$") end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
				},
			},
			cpp = dap.configurations.c,
			rust = dap.configurations.c,
		}
	end,
}
