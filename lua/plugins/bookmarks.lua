-- vim: ts=2 sts=2 sw=2 et

-- - mm → Toggle a bookmark on the current line.
-- - mi → Show all bookmarks.
-- - mn / mp → Jump to next/previous bookmark.
return {
	"MattesGroeger/vim-bookmarks",
	lazy = false,

	config = function()
		local map = function(mode, lhs, rhs, desc)
			local opts = {}
			opts.desc = "Bookmark: " .. desc
			opts.silent = true
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		map("n", "<leader>mm", "<cmd>BookmarkToggle<CR>", "Toggle")
		map("n", "<leader>mi", "<cmd>BookmarkShowAll<CR>", "Show All")
		map("n", "<leader>mn", "<cmd>BookmarkNext<CR>", "Next")
		map("n", "<leader>mp", "<cmd>BookmarkPrev<CR>", "Previous")
		map("n", "<leader>mM", "<cmd>BookmarkClear<CR>", "Clear All")
		map("n", "<leader>ma", "<cmd>BookmarkAnnotate<CR>", "Annotate")
		map("n", "<leader>ms", "<cmd>BookmarkShowAll<CR>", "Show All")

		require("which-key").add({
			{ "<leader>m", group = "Bookmarks", icon = "🔖" },
		})
	end,
}
