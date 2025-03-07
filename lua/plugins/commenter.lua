-- Shortcut to toggle comment lines based on language
return {
	{
		"tpope/vim-commentary",
		options = {},
		config = function()
			-- alternativaly, you can use gcc
			vim.keymap.set("i", "<C-/>", "<cmd>Commentary<CR>", { silent = true, desc = "Comment" })
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
