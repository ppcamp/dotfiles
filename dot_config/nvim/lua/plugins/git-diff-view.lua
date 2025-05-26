-- vim: ts=2 sts=2 sw=2 et

return {
	"sindrets/diffview.nvim",
	priority = 10,
	config = function()
		require("diffview").setup()

		local map = function(lhs, rhs, mode, opts)
			opts = opts or {}
			mode = mode or "n"
			opts.silent = true
			opts.noremap = true
			vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
		end

		map("<leader>gdd", "<cmd>DiffviewOpen<CR>")
		map("<leader>gdD", "<cmd>DiffviewClose<CR>")
		map("<leader>gdr", "<cmd>DiffviewRefresh<CR>")
		map("<leader>gdv", "<cmd>DiffviewToggleFiles<CR>")
		map("<leader>gdp", "<cmd>DiffviewFileHistory %<CR>")

		require("which-key").add({
			{ "<leader>gd", desc = "DiffView" },
			-- { "<leader>gD", desc = "DiffView: Close" },
			-- { "<leader>gr", desc = "DiffView: Refresh" },
			-- { "<leader>gv", desc = "DiffView: Toggle Files" },
			-- { "<leader>gp", desc = "DiffView: File History" },
		})
	end,
}
