-- vim: ts=2 sts=2 sw=2 et

-- LSP Plugins
--
-- Language server protocol (used to generate editors errors, code navigation, etc)

return {
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true },

	{ -- Inlay hints plugin
		"lvimuser/lsp-inlayhints.nvim",
	},

	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/which-key.nvim",
			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			--

			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			local wk = require("which-key")
			local cmd = vim.api.nvim_create_autocmd
			local augroup = vim.api.nvim_create_augroup

			---Alternative to map
			---@param keys string
			---@param func function | string
			---@param desc string
			---@param mode ? table | string
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
			end

			-- Jump LSP errors
			map("]g", vim.diagnostic.goto_next, "Goto next")
			map("[g", vim.diagnostic.goto_prev, "Goto previous")

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer

			cmd("LspAttach", {
				group = augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- Add group icon
					-- It needs to be added here, otherwise, vim.bo.filetype will be empty
					local icon = {
						name = vim.bo.filetype,
						cat = "filetype",
					}
					wk.add({
						{ "<leader>l", group = "LSP", icon = icon },
						{ "<leader>nd", icon = icon },
						{ "<leader>nr", icon = icon },
						{ "<leader>ni", icon = icon },
						{ "<leader>nt", icon = icon },
						{ "<leader>sw", icon = icon },
						{ "<leader>sW", icon = icon },
						{ "<leader>sq", icon = icon },
						{ "<leader>ca", icon = icon },
					})
					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("<leader>nd", require("telescope.builtin").lsp_definitions, "Goto Definition")
					map("<F12>", require("telescope.builtin").lsp_definitions, "Goto Definition")

					-- Find references for the word under your cursor.
					map("<leader>nr", require("telescope.builtin").lsp_references, "Goto References")
					map("<S-F12>", require("telescope.builtin").lsp_references, "Goto References")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("<leader>ni", require("telescope.builtin").lsp_implementations, "Goto Implementation")
					map("<C-F12>", require("telescope.builtin").lsp_implementations, "Goto Implementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>nt", require("telescope.builtin").lsp_type_definitions, "Type Definition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>sw", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("<leader>sW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

					-- Diagnostics
					map("<leader>sq", require("telescope.builtin").diagnostics, "Diagnostics")

					--

					-- Diagnostic keymaps
					map("<leader>cq", vim.diagnostic.setloclist, "Quickfix panel")

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<F2>", vim.lsp.buf.rename, "Rename", { "n", "i" })

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
					map("<C-.>", vim.lsp.buf.code_action, "Code Action", { "i" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("<leader>nD", vim.lsp.buf.declaration, "Goto Declaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						vim.lsp.inlay_hint.enable(true)
						require("lsp-inlayhints").on_attach(client, event.buf)

						map("<leader>lh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle Inlay Hints")
					end

					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup = augroup("kickstart-lsp-highlight", { clear = false })

						cmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						cmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						cmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.

			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			---@module "lspconfig"
			---@type table
			local servers = {
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim

				-- bufls = {}, -- protobuff
				-- clangd = {}, -- C++
				-- cmake = {},
				-- cssls = {},
				-- cucumber_language_server
				-- denols = {},
				-- dotls
				-- elixirls
				-- eslint
				-- gitlab_ci_ls
				-- glint
				-- golangci_lint_ls
				-- graphql
				-- html
				-- htmx
				-- java_language_server
				-- jqls
				-- jsonld-lsp
				-- jsonls
				-- julials
				-- kotlin_language_server
				-- nginx_language_server
				-- ocamllsp
				-- opencl_ls
				-- perlnavigator
				-- phpactor
				-- pico8-ls pico8_ls
				-- powershell_es
				-- protols
				-- psalm
				-- pylsp
				-- pylyzer
				-- pyright
				-- r_language_server
				-- ruby_lsp
				-- rust_analyzer
				-- rust_analyzer = {},
				-- svelte
				-- systemd-language-server
				-- tailwindcss
				-- termux-language-server
				-- terraformls
				-- volar
				-- ts_ls

				bashls = {},
				docker_compose_language_service = {},
				dockerls = {},
				gopls = {
					settings = {
						gopls = {
							-- directoryFilters = {
							--     "-",
							--     "+" .. cwd,
							-- },
							-- Exclude the 'pkg' directory from being indexed
							analyses = {
								unusedparams = true,
								modernize = true,
							},
							staticcheck = true,
							hints = {
								rangeVariableTypes = true,
								parameterNames = true,
								constantValues = true,
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								functionTypeParameters = true,
							},
						},
					},
				},
				intelephense = {},
				lua_ls = { -- lua_language_server
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				markdown_oxide = {},
				marksman = {},
				sqls = {},
			}

			---@type table<string>
			local mason_dap = {
				"delve",
				"cpptools",
			}

			local utils = require("utils.tables")

			local mason_lsp = utils.keys(servers) or {}
			local tools = utils.extend(vim.tbl_keys({}), mason_lsp, mason_dap)

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			---@diagnostic disable-next-line: missing-fields
			-- require("mason").setup({})

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			-- local ensure_installed = vim.tbl_keys(servers or {})

			-- NOTE that if you do need to have this installed, you must install it manually by doing
			-- cargo install stylua
			-- vim.list_extend(ensure_installed, {
			--   'stylua', -- Used to format Lua code
			-- })
			require("mason-tool-installer").setup({
				ensure_installed = tools,
			})

			require("mason-lspconfig").setup({
				-- install
				ensure_installed = {}, -- explicitly set to an empty table
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
