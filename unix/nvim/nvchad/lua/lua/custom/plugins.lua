local plugins = {
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			max_time = 500,
			max_count = 5,
			disable_mouse = false,
		},
	},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			automatic_installation = { exclude = { "lua_ls" } },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {},
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end,
	},
	{
		"hinell/lsp-timeout.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			vim.g["lsp-timeout-config"] = {
				stopTimeout = 1000 * 60 * 5,
				startTimeout = 1000 * 10,
				silent = false,
			}
		end,
	},
	{ "mfussenegger/nvim-lint", event = { "BufReadPre", "BufNewFile", }, },
	{
		'stevearc/conform.nvim',
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer with Conform.",
			},
		},
		opts = {},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" -- If you want the formatexpr, here is the place to set it
		end,
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		opts = {},
		config = function()
			dofile(vim.g.base46_cache .. "dap")
			require "custom.configs.dapconfig"
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim"
		}
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", },
		opts = {},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = {},
	},
	{
		'stevearc/overseer.nvim',
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		opts = {},
	},
	{ "folke/neodev.nvim", opts = {}, dependencies = { "hrsh7th/nvim-cmp", } },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
	{
		"folke/zen-mode.nvim",
		opts = {},
		cmd = { "ZenMode", },
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			dofile(vim.g.base46_cache .. "trouble")
			require("trouble").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function()
			dofile(vim.g.base46_cache .. "todo")
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		opts = {},
		config = function()
			local highlight = dofile(vim.g.base46_cache .. "rainbowdelimiters")
			local rainbow_delimiters = require "rainbow-delimiters"
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = rainbow_delimiters.strategy['global'],
					vim = rainbow_delimiters.strategy['local'],
				},
				query = {
					[''] = 'rainbow-delimiters',
					lua = 'rainbow-blocks',
				},
				highlight = highlight,
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		init = function()
			require("core.utils").lazy_load "indent-blankline.nvim"
		end,
		opts = function()
			return require("plugins.configs.others").blankline
		end,
		config = function(_, opts)
			require("core.utils").load_mappings "blankline"
			dofile(vim.g.base46_cache .. "blankline")
			require("indent_blankline").setup(opts)
		end,
	},
	{
		"wansmer/symbol-usage.nvim",
		event = "bufReadPre",
		config = function()
			require "custom.configs.symbol"
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		dependencies = {
			{ "kevinhwang91/nvim-hlslens", dependencies = { "kevinhwang91/nvim-ufo", }, },
			"lewis6991/gitsigns.nvim",
		},
		opts = {},
		config = function ()
			require("scrollbar").setup()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar.handlers.search").setup({})
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			{ "SmiteshP/nvim-navic", },
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = { },
	},
	{
		"luukvbaal/statuscol.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"lewis6991/gitsigns.nvim",
		},
		opts = {},
		config = function ()
			require "custom.configs.statuscol"
		end
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = { "120", "150" },
			disabled_filetypes = { "help", "text", "markdown", "NvimTree", "lazy", "mason", },
		},
	},
	{
		'kosayoda/nvim-lightbulb',
		opts = { autocmd = { enabled = true, }, }
	},
	{
		"chrisgrieser/nvim-tinygit",
		ft = { "gitrebase", "gitcommit" }, -- so ftplugins are loaded
		dependencies = {
			"stevearc/dressing.nvim",
			"rcarriga/nvim-notify", -- optional, but recommended
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim",        -- optional
			"ibhagwan/fzf-lua",              -- optional
		},
		opts = {},
	},
}
return plugins
