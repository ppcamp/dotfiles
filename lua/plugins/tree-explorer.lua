-- Show a explorer view, with folders, and file icons
--

--- Define your custom on_attach_change function
--- @param bufnr integer
-- local on_attach_change = function(bufnr)
-- 	-- Here, you can define any actions you want to take when nvim-tree is opened
-- 	-- For example, you can bind specific keys or trigger other events
--
-- 	-- Example: Setting some keybindings for the NvimTree buffer
-- 	local opts = { noremap = true, silent = true }
--
-- 	-- Add custom key mappings for the nvim-tree buffer
-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "a", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree when 'a' is pressed
-- end

return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = { on_attach = on_attach_change },

		-- open it by typing :NvimTreeToggle
		-- and then, you can type "a"
	},
}

-- vim: ts=2 sts=2 sw=2 et
