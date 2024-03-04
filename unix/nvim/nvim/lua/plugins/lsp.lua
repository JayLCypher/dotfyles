return {
	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		dependencies = {
			{
				"folke/neodev.nvim",
				opts = {
					library = {
						plugins = {
							"nvim-dap-ui",
						},
						types = true,
					},
				},
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc .. " [LSP]" }) end
					map("gd", require("telescope.builtin").lsp_definitions, "Definition")
					map("gD", vim.lsp.buf.declaration, "Declaration")
					map("gr", require("telescope.builtin").lsp_references, "References")
					map("gI", require("telescope.builtin").lsp_implementations, "Implementations")
					map("gY", require("telescope.builtin").lsp_type_definitions, "Type definition")
					map("gs", require("telescope.builtin").lsp_document_symbols, "Document symbols")
					map("gw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
					map("<leader>r", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("gK", vim.lsp.buf.hover, "Hover documentation")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			---@class lsp.ClientCapabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local lspconfig = require("lspconfig")
			lspconfig.capabilities = capabilities
			lspconfig.diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
			}
			lspconfig.inlay_hints = {
				enabled = true,
			}
			lspconfig.format = {
				formatting_options = nil,
				timeout_ms = nil,
			}

			local servers = {
				lua_ls = {
					-- cmd = {...},
					-- filetypes { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
								-- disable = { 'missing-fields' } -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							},
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded for your neovim configuration.
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
									[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
								},
								maxPreload = 100000,
								preloadFileSize = 10000,
							},
							completion = {
								callSnippet = "Replace",
							},
							telemetry = { enable = false },
						},
					},
				},
				clangd = {
					capabilities = vim.tbl_deep_extend("force", capabilities, {
						textDocument = {
							completion = {
								editsNearCursor = true,
							},
						},
						offsetEncoding = { "utf-8", "utf-16" },
					}),
				},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup { ensure_installed = ensure_installed }
			require("mason-lspconfig").setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			}
		end,
	},
}
