-- vim: ts=2 sts=2 sw=2 et

return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",

	config = function()
		-- Better Around/Inside textobjects
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
		--
		-- This plugin also enable ci`, di`, ca`, da` and so on
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		-- add            = 'sa', to Add surrounding in Normal and Visual modes
		-- delete         = 'sd', to Delete surrounding
		-- find           = 'sf', to Find surrounding (to the right)
		-- find_left      = 'sF', to Find surrounding (to the left)
		-- highlight      = 'sh', to Highlight surrounding
		-- replace        = 'sr', to Replace surrounding
		-- update_n_lines = 'sn', to Update `n_lines`
		-- suffix_last    = 'l',  to Suffix to search with "prev" method
		-- suffix_next    = 'n',  to Suffix to search with "next" method
		--
		-- sai(" to add surrounding in everything inside the parentheses
		require("mini.surround").setup()

		-- Add/Remove indentation
		-- gas to -> align text like below
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
		--
		-- Press s                to enter split Lua pattern.
		-- Press j                to choose justification side from available ones ("left", "center", "right", "none").
		-- Press m                to enter merge delimiter.
		-- Press f                to enter filter Lua expression               to configure which parts will be affected (like "align only first column").
		-- Press i                to ignore some commonly unwanted split matches.
		-- Press p                to pair neighboring parts so they be aligned together.
		-- Press t                to trim whitespace from parts.
		-- Press <BS> (backspace) to delete some last pre-step.
		require("mini.align").setup()

		-- Move using alt+hjkl keys
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
		--
		require("mini.move").setup()

		-- Add animations to scroll, window resizing, and other actions
		-- require("mini.animate").setup()

		-- Add notification plugin popup
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-notify.md
		-- require("mini.notify").setup({})
	end,
}
