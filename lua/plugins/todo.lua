-- @p
-- BUG:
-- FIX:
-- FIXME:
-- HACK:
-- INFO:
-- NOTE:
-- OPTIM:
-- OPTIMIZE:
-- PERF:
-- PERFORMANCE:
-- TESTING:
-- FAILED:
-- PASSED:
-- TODO:
-- WARN:
-- WARNING:
-- XXX:
-- IDEA:
-- CHECK:
-- REVIEW:
-- ASK:
-- QUESTION:

-- Highlight todo, notes, etc in comments
return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
		config = function()
			vim.keymap.set(
				"n",
				"<leader>se",
				"<cmd>TodoTelescope<cr>",
				{ desc = "TODO: search", noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>td",
				"<cmd>TodoQuickFix<CR>",
				{ desc = "TODO: Quickfix panel", noremap = true, silent = true }
			)

			local todo = require("todo-comments")
			todo.setup({
				keywords = {
					REVIEW = { icon = "", color = "hint", alt = { "CHECK" } },
					IDEA = { icon = "", color = "info", alt = { "THEORY" } },
					QUESTION = { icon = "󱜺", color = "warning", alt = { "ASK" } },
				},
			})
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
