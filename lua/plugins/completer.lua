-- vim: ts=2 sts=2 sw=2 et

-- Autocompletion support.
--
-- With this, we'll be able to generate and accept suggestions from LSP

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		priority = 500,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			{ -- Snippet Engine & its associated nvim-cmp source
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- friendly-snippets
					-- contains a variety of premade snippets.
					-- See the README about individual language/framework/plugin snippets:
					-- https://github.com/rafamadriz/friendly-snippets
					"friendly-snippets",
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			luasnip.config.setup()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				sources = {
					{ name = "copilot" },
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
				mapping = {
					["<C-J>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end),

					["<C-K>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end),

					["<C-U>"] = cmp.mapping(function(fallback)
						if cmp.visible_docs() then
							cmp.mapping.scroll_docs(-4)
						elseif fallback then
							fallback()
						end
					end),

					["<C-D>"] = cmp.mapping(function(fallback)
						if cmp.visible_docs() then
							cmp.mapping.scroll_docs(4)
						else
							fallback()
						end
					end),

					-- Alternativaly, use K while "n"
					["<C-g>"] = cmp.mapping(function()
						if cmp.visible_docs() then
							return cmp.close_docs()
						else
							return not cmp.open_docs() or vim.lsp.buf.hover()
						end
					end),

					-- note that you cannot use c-i, otherwise, tab will be impacted
					-- how to	 create a shortcut to ctrl+.?
					["<C-e>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.close({})
						else
							cmp.complete()
						end
					end),

					["<C-Space>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							return -- fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						elseif fallback then
							return fallback()
						end
					end),

					["<C-L>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							return cmp.confirm({ select = true })
						elseif fallback then
							fallback()
						end
					end),

					["<C-n>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end),
				},
			})
		end,
	},
}
