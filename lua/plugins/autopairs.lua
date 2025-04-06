-- vim: ts=2 sts=2 sw=2 et

-- autopairs
--
-- Generate a matching pair for braces{}, parenthesis(), square bracket[], and so goes on.
-- https://github.com/windwp/nvim-autopairs

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	-- Optional dependency
	priority = 70,
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true, -- enable treesitter integration
			disable_filetype = { "TelescopePrompt", "vim" },
			enable_afterquote = true, -- auto close after quote
		})

		-- If you want to automatically add `(` after selecting a function or method
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
