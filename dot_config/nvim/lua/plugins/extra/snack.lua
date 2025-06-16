-- lazy.nvim
return {
	"folke/snacks.nvim",
	opts = {
		---@type snacks.lazygit.Config
		lazygit = {
			-- your lazygit configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	config = function(_, opts)
		local snacks = require("snacks")
		snacks.setup(opts)

		vim.keymap.set("n", "<leader>gl", function()
			snacks.lazygit.log()
		end, { desc = "Open LazyGit" })
	end
}
