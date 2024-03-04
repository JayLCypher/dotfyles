return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- Snippets
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			opts = {
				history = true,
				delete_check_event = "TextChanged",
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",

		-- completions
		"hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-calc",
		-- "hrsh7th/cmp-path",
		-- "FelipeLema/cmp-async-path",
		"hrsh7th/cmp-cmdline",

		-- git
		"petertriho/cmp-git",
		"davidsierradz/cmp-conventionalcommits",
		"Dosx001/cmp-commit",
		"Dynge/gitmoji.nvim",

		-- Shell
		"mtoohey31/cmp-fish",

		-- Icons and Symbols
		"hrsh7th/cmp-emoji",
		"chrisgrieser/cmp-nerdfont",
		"max397574/cmp-greek",
		"kdheepak/cmp-latex-symbols",

		-- Other comparators
		"lukas-reineke/cmp-under-comparator",

		-- CSS and colors
		"nat-418/cmp-color-names.nvim",
		"Jezda1337/nvim-html-css",
		"mmolhoek/cmp-scss",

		-- Misc
		"delphinus/cmp-ctags",
		"rcarriga/cmp-dap",
	},
	opts = function() return end,
	config = function(_, _)
		local cmp_kinds = {
			Text = "  ",
			Method = "  ",
			Function = "  ",
			Constructor = "  ",
			Field = "  ",
			Variable = "  ",
			Class = "  ",
			Interface = "  ",
			Module = "  ",
			Property = "  ",
			Unit = "  ",
			Value = "  ",
			Enum = "  ",
			Keyword = "  ",
			Snippet = "  ",
			Color = "  ",
			File = "  ",
			Reference = "  ",
			Folder = "  ",
			EnumMember = "  ",
			Constant = "  ",
			Struct = "  ",
			Event = "  ",
			Operator = "  ",
			TypeParameter = "  ",
		}
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup()
		cmp.setup {
			completion = { completeopt = "menu,menuone,noinsert" },
			formatting = {
				fields = { "kind", "abbr" },
				format = function(_, vim_item)
					vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
					return vim_item
				end,
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Esc>"] = function(fallback)
					cmp.mapping.abort()
					cmp.abort()
					fallback()
				end,
				["<CR>"] = cmp.mapping {
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm { select = true },
					c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
				},
				["<S-CR>"] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
			},
			sources = cmp.config.sources {
				{ name = "luasnip" }, -- For luasnip users.
				-- { name = 'vsnip' }, -- For vsnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				-- LSP
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				-- { name = "nvim_lsp_document_symbol" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "dap" },
				-- Buffer
				{ name = "calc" },
				-- { name = "path" },
				{ name = "async_path" },
				{
					name = "ctags",
					-- default values
					option = {
						executable = "ctags",
						trigger_characters = { "." },
						trigger_characters_ft = {
							c = { ".", "->" },
							cpp = { ".", "->", "::" },
							perl = { "->", "::" },
						},
					},
				},
				{ name = "fish" },
				-- Icons and Symbols
				{ name = "nerdfont" },
				{ name = "greek" },
				{ name = "emoji" },
				{ name = "latex_symbols" },
				-- CSS and colors
				{ name = "nvim-html-css" },
				{ name = "cmp-scss" },
				{ name = "color_names" },
			},
			{ { name = "buffer" } },
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
			filetype = {
				"gitcommit",
				{
					sources = cmp.config.sources({
						{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
						{ name = "conventionalcommits" },
						{ name = "commit" },
						{ name = "gitmoji" },
					}, {
						{ name = "buffer" },
					}),
				},
			},
			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmdline = {
				{ { "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" },
					},
				} },
				{
					":",
					{
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = "path" },
						}, {
							{ name = "cmdline" },
						}),
					},
				},
			},
			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		}
	end,
}
