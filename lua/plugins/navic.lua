-- vim: ts=2 sts=2 sw=2 et

return {
	"SmiteshP/nvim-navic",
	lazy = true,
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		local navic = require("nvim-navic")
		navic.setup({
			lsp = {
				auto_attach = true,
			},
		})
	end,
}
