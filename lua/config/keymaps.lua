local map = vim.keymap.set
local wk = require("which-key")
local autocmd = vim.api.nvim_create_autocmd

--#region Keybindings

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("i", "jk", "<Esc>", { noremap = true, desc = "Exit from edit mode" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { silent = true })
map("n", "<Tab>", ":bnext<CR>", { desc = "While hit tab, will change to next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "While hit Shift+tab, will change to next buffer" })
map("n", "<C-d>", "<C-q>", { noremap = true, desc = "Similar to multicursor approach" })
map(
	"n",
	"<C-q>",
	":bd<CR>",
	{ noremap = true, silent = true, desc = "While in insert mode, when hit Ctrl+Q, will close the current buffer" }
)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Window: Move focus to the left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Window: Move focus to the right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Window: Move focus to the lower" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Window: Move focus to the upper" })

-- Git
map("n", "<leader>gs", ":Telescope git_stash<CR>", { desc = "Git: Stash" })
map("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git: Commits" })
map("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git: Branches" })
map("n", "<leader>gf", ":Telescope git_files<CR>", { desc = "Git: Files" })
map("n", "<leader>gt", ":Telescope git_status<CR>", { desc = "Git: Status" })

-- Conditional maps to file openned only
--
-- NOTE: that we already have the next/prev line by typing in normal mode
--- { or }
--
-- autocmd("BufEnter", {
-- 	-- Navegate to empty blank lines
-- 	once = true,
-- 	callback = function()
-- 		if vim.bo.buftype == "" then
-- 			map("n", "<leader>nn", "/^\\s*$<CR>", { desc = "Goto: Next empty line" })
-- 			map("n", "<leader>nN", "?^\\s*$<CR>", { desc = "Goto: Prev empty line" })
-- 			--	else
-- 			--		vim.keymap.del("n", "<leader>nn")
-- 			--		vim.keymap.del("n", "<leader>nN")
-- 		end
-- 	end,
-- })
--#endregion

--#region icons
-- Add extra icons and texts
wk.add({
	{ "<leader>g", group = "Git" },
	{ "<leader>t", icon = "", group = "Tools" },
	{ "<leader>n", icon = "󱣱", group = "Navigation" },
	{ "<leader>c", group = "Code", mode = { "n", "x" } },
	{ "<leader>d", group = "Document" },
	{ "<leader>s", group = "Search" },
	{
		"<leader>?",
		function()
			require("which-key").show({ global = false })
		end,
		desc = "Keymaps (which-key)",
		icon = { icon = "", color = "green" },
	},
	{
		"<leader>tb",
		desc = "Functions: My",
		function()
			print("Type of current file is " .. vim.bo.filetype)
		end,
	},
})
--#endregion

-- vim: ts=2 sts=2 sw=2 et
