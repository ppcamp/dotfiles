-- Copilot AI configuration for Neovim
--
-- To setup local, run :Copilot setup
--
-- See `:help copilot` for more information.

--
-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--                                                 *copilot-i_ALT-]*
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <Plug>(copilot-next)
--
--                                                 *copilot-i_ALT-[*
-- <M-[>                   Cycle to the previous suggestion.
-- <Plug>(copilot-previous)
--
--                                                 *copilot-i_ALT-\*
-- <M-\>                   Explicitly request a suggestion, even if Copilot
-- <Plug>(copilot-suggest) is disabled.
--
--                                                 *copilot-i_ALT-Right*
-- <M-Right>               Accept the next word of the current suggestion.
-- <Plug>(copilot-accept-word)
--
--                                                 *copilot-i_ALT-CTRL-Right*
--
-- <M-C-Right>             Accept the next line of the current suggestion.
-- <Plug>(copilot-accept-line)

return {
	"github/copilot.vim",
	enabled = true,
	priority = 200,
	-- config = function()
	-- 	vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
	-- 		expr = true,
	-- 		replace_keycodes = true,
	-- 		noremap = true,
	-- 	})
	-- end,
}

-- vim: ts=2 sts=2 sw=2 et
