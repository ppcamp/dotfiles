local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

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
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map({ "n" }, "<leader>tt", "<cmd> Telescope <cr>", { silent = true, desc = "Opens Telescope selection" })

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

-- local wk = require("which-key")
-- wk.add({
--     { "<leader>f", group = " Completions" }, -- group
--     { "<leader>fn", desc = "<C-n> Select the [n]ext item" },
--     { "<leader>fp", desc = "<C-p> Select the [p]revious item" },
--     { "<leader>fb", desc = "<C-b> Scroll the documentation window [b]ack" },
--     { "<leader>ff", desc = "<C-f> Scroll the documentation window [f]orward" },
--     { "<leader>fy", desc = "<C-y> Accept ([y]es) the completion" },
--     { "<leader>fs", desc = "<C-Space> Manually trigger a completion from nvim-cmp" },
--
--     { "<leader>z", group = " Tools" },
--     { "<leader>zb", function() print("hello") end, desc = "Foobar" },
--     --   { "<leader>f1", hidden = true }, -- hide this keymap
--     --   { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
--     --   { "<leader>b", group = "buffers", expand = function()
--     --       return require("which-key.extras").expand.buf()
--     --     end
--     --   },
-- })

-- vim: ts=2 sts=2 sw=2 et
