return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Optional
		"BurntSushi/ripgrep",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		-- Extensions
		{ -- If encountering errors, see telescope-fzf-native README for install instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function() return vim.fn.executable("make") == 1 end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	keys = {
		{ "<leader>fs", function() require("telescope.builtin").builtin() end, desc = "[Telescope] Find Select" },
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "[Telescope] Find Files" },
		{ "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "[Telescope] Find Word" },
		{ "<leader>fd", function() require("telescope.builtin").diagnostics() end, desc = "[Telescope] Find Word" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "[Telescope] Find Help" },
		{ "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "[Telescope] Find Keymaps" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "[Telescope] Live Grep" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "[Telescope] Show open buffers" },
		{ "<leader>fr", function() require("telescope.builtin").resume() end, desc = "[Telescope] Find Resume" },
		-- Slightly advanced example of overriding default behavior and theme
		{
			"<leader>/",
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end,
			desc = "[Telescope] Fuzzyfind in current buffer",
		},
		{
			"<leader>s/",
			function()
				require("telescope.builtin").live_grep {
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				}
			end,
			desc = "[Telescope] Find in Open Files",
		},
		{
			"<leader>fn",
			function() require("telescope.builtin").find_files { cwd = vim.fn.stdpath("config") } end,
			desc = "[Telescope] Neovim config",
		},
	},
	config = function(_, _)
		local telescope = require("telescope")
		telescope.setup {
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		}
		pcall(telescope.load_extension, "fzf") -- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "dap")
		pcall(telescope.load_extension, "notify")
	end,
}
