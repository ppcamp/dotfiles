-- Nvim startpage

return {
	"goolord/alpha-nvim",

	config = function()
		local theme = require("alpha.themes.startify").config
		require("alpha").setup(theme)
	end,
}

-- vim: ts=2 sts=2 sw=2 et
