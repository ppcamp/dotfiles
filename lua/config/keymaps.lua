-- vim: ts=2 sts=2 sw=2 et

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- local wk = require("which-key")

--#region Keybindings

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("v", ";", "<Esc>")
-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split vertical
map("n", "<leader>%", ":vsplit<CR>", { desc = "Split vertically" })
-- map("n", "<leader>e", ":enew<CR>", { desc = "New buffer" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("i", "jk", "<Esc>", { noremap = true, desc = "Exit from edit mode" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { silent = true })
map("n", "<Tab>", ":bnext<CR>", { desc = "While hit tab, will change to next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "While hit Shift+tab, will change to next buffer" })
-- map("n", "<C-d>", "<C-q>", { noremap = true, desc = "Similar to multicursor approach" })
-- map(
--   "n",
--   "<C-q>",
--   ":bd<CR>", -- quit works for buffers/quickfix panels (for splits, use ctrl+w q )
--   { noremap = true, silent = true, desc = "While in insert mode, when hit Ctrl+Q, will close the current buffer" }
-- )
--
-- -- Keybinds to make split navigation easier.
-- --  Use CTRL+<hjkl> to switch between windows
-- --
-- --  See `:help wincmd` for a list of all window commands
-- map("n", "<C-h>", "<C-w><C-h>", { desc = "Window: Move focus to the left" })
-- map("n", "<C-l>", "<C-w><C-l>", { desc = "Window: Move focus to the right" })
-- map("n", "<C-j>", "<C-w><C-j>", { desc = "Window: Move focus to the lower" })
-- map("n", "<C-k>", "<C-w><C-k>", { desc = "Window: Move focus to the upper" })
--
-- --#region icons
-- -- Add extra icons and texts
-- wk.add({
--   { "<leader>g", group = "Git", mode = { "n", "v" } },
--   { "<leader>t", icon = "", group = "Tools", mode = { "n", "v" } },
--   { "<leader>n", icon = "󱣱", group = "Navigation", mode = { "n", "v" } },
--   { "<leader>c", group = "Code", mode = { "n", "x" } },
--   { "<leader>d", group = "Document" },
--   { "<leader>s", group = "Search", mode = { "n", "v" } },
--   { "<leader>?", group = "Help", icon = { icon = "", color = "green" }, mode = { "n", "v" } },
--   {
--     "<leader>?w",
--     function()
--       require("which-key").show({ global = false })
--     end,
--     desc = "Keymaps (which-key)",
--   },
--   { "<leader>?c", ":Copilot help<CR>", desc = "Copilot: Help" },
--   {
--     "<leader>tb",
--     desc = "Functions: My",
--     function()
--       print("Type of current file is " .. vim.bo.filetype)
--     end,
--   },
-- })
--#endregion
