return {
	{
		"akinsho/bufferline.nvim",
		event = { "VeryLazy", "BufNewFile", "BufReadPre" },
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
		keys = {
			{ "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Buffer Cycle Next", silent = true },
			{ "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Buffer Cycle Prev", silent = true },

			{ "<leader>B$", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Goto Buffer -1", silent = true },
			{ "<leader>B1", "<Cmd>BufferLineGoToBuffer 1<CR> ", desc = "Goto Buffer 1", silent = true },
			{ "<leader>B2", "<Cmd>BufferLineGoToBuffer 2<CR> ", desc = "Goto Buffer 2", silent = true },
			{ "<leader>B3", "<Cmd>BufferLineGoToBuffer 3<CR> ", desc = "Goto Buffer 3", silent = true },
			{ "<leader>B4", "<Cmd>BufferLineGoToBuffer 4<CR> ", desc = "Goto Buffer 4", silent = true },
			{ "<leader>B5", "<Cmd>BufferLineGoToBuffer 5<CR> ", desc = "Goto Buffer 5", silent = true },
			{ "<leader>B6", "<Cmd>BufferLineGoToBuffer 6<CR> ", desc = "Goto Buffer 6", silent = true },
			{ "<leader>B7", "<Cmd>BufferLineGoToBuffer 7<CR> ", desc = "Goto Buffer 7", silent = true },
			{ "<leader>B8", "<Cmd>BufferLineGoToBuffer 8<CR> ", desc = "Goto Buffer 8", silent = true },
			{ "<leader>B9", "<Cmd>BufferLineGoToBuffer 9<CR> ", desc = "Goto Buffer 9", silent = true },

			{ "<leader>x", "<cmd>bd<CR>", desc = "Close current buffer", silent = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
			},
			extensions = { "fzf", "lazy", "man", "mason", "nvim-dap-ui", "nvim-tree", "overseer", "quickfix", "trouble" },
		},
		config = function(_)
			local function cur_active_keymap()
				if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then return "⌨ " .. vim.b.keymap_name end
				return ""
			end
			-- vim.api.nvim_win_get_number(0)
			local function cur_active_window() return "⊞ " .. vim.api.nvim_win_get_buf(0) end
			local function location()
				local line = vim.fn.line(".")
				local col = vim.fn.virtcol(".")
				local bin = vim.fn.line2byte(line) + col
				return string.format("%3d:%-2d | B%d", line, col, bin)
			end

			local function get_attached_clients()
				local buf_clients = vim.lsp.get_clients { bufnr = 0 }
				if #buf_clients == 0 then return "" end

				local buf_ft = vim.bo.filetype
				local buf_client_names = {}

				-- add client
				for _, client in pairs(buf_clients) do
					if client.name ~= "copilot" and client.name ~= "null-ls" then table.insert(buf_client_names, client.name) end
				end
				-- This needs to be a string only table so we can use concat below
				local unique_client_names = {}
				for _, client_name_target in ipairs(buf_client_names) do
					local is_duplicate = false
					for _, client_name_compare in ipairs(unique_client_names) do
						if client_name_target == client_name_compare then is_duplicate = true end
					end
					if not is_duplicate then table.insert(unique_client_names, client_name_target) end
				end

				local client_names_str = table.concat(unique_client_names, ", ")
				local language_servers = string.format("[%s]", client_names_str)

				return language_servers
			end

			local lualine = require("lualine")
			local cfg = lualine.get_config()
			cfg.options.theme = "auto"
			cfg.extensions = { "fzf", "lazy", "man", "mason", "nvim-dap-ui", "nvim-tree", "overseer", "quickfix", "trouble" }
			table.insert(cfg.sections.lualine_b, { cur_active_window })
			cfg.sections.lualine_y = { "progress", get_attached_clients, { cur_active_keymap } }
			cfg.sections.lualine_z = { location }
			lualine.setup(cfg)
		end,
	},
}
