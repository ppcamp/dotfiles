-- vim: ts=2 sts=2 sw=2 et

-- It shows nvim cheatsheet

return {
	"mrjones2014/legendary.nvim",
	-- since legendary.nvim handles all your keymaps/commands,
	-- its recommended to load legendary.nvim before other plugins
	priority = 10000,
	lazy = false,
	-- sqlite is only needed if you want to use frecency sorting
	-- dependencies = { 'kkharji/sqlite.lua' },
	config = function()
		vim.keymap.set(
			"n",
			"<leader>?v",
			"<cmd>Legendary<cr>",
			{ desc = "Legendary: Nvim cheatsheet", noremap = true, silent = true }
		)
	end,
}
