-- Copilot AI configuration for Neovim
--
-- To setup local, run :Copilot setup
return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = true,
			noremap = true,
		})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
