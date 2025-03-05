local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local wk = require("which-key")

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

-- Diagnostic keymaps
map("n", "<leader>cq", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Telescope higher functions
map({ "n" }, "<leader>tt", "<cmd> Telescope <cr>", { silent = true, desc = "Opens Telescope" })
map({ "n" }, "<leader>tc", "<cmd> Telescope commands<cr>", { silent = true, desc = "Telescope commands" })
map({ "n" }, "<leader>sm", "<cmd> Telescope man_pages<cr>", { silent = true, desc = "Telescope man pages" })

-- Git
map("n", "<leader>gs", ":Telescope git_stash<CR>", { desc = "Git Stash" })
map("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git Commits" })
map("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git Branches" })
map("n", "<leader>gf", ":Telescope git_files<CR>", { desc = "Git Files" })
map("n", "<leader>gt", ":Telescope git_status<CR>", { desc = "Git Status" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Add extra icons and texts
wk.add({
	{ "<leader>g", group = "Git" },
	{ "<leader>t", icon = "", group = "Tools" },
	{ "<leader>c", group = "Code", mode = { "n", "x" } },
	{ "<leader>d", group = "Document" },
	{ "<leader>s", group = "Search" },
	{
		"<leader>tb",
		desc = "Example of a function",
		function()
			print("hello")
		end,
	},
})

-- vim: ts=2 sts=2 sw=2 et
