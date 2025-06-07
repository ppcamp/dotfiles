-- vim: ts=2 sts=2 sw=2 et

local wk = require("which-key")
local map = require("utils.map").map

--#region Keybindings

map("<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")
map("<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode", "t")
map("ZZ", "<cmd>noautocmd wq<CR>", "Save and quit without autocommands")
map("<leader>%", ":vsplit<CR>", "Split vertically")
map("<leader>e", ":enew<CR>", "New buffer")
map("jk", "<Esc>", "Exit from edit mode", { "i", "v" })
map(";", ":", "CMD enter command mode")
map("<C-s>", "<cmd> w <cr>", { desc = "Save", silent = true }, { "n", "i", "v" })
map("<Tab>", ":bnext<CR>", "While hit tab, will change to next buffer")
map("<S-Tab>", ":bprevious<CR>", "While hit Shift+tab, will change to next buffer")
map("<C-q>", ":bd<CR>", "While in insert mode, when hit Ctrl+Q, will close the current buffer") -- quit works for buffers/quickfix panels (for splits, use ctrl+w q )

-- Keybinds to make split navigation easier.
map("<C-h>", "<C-w><C-h>", "Window: Move focus to the left")
map("<C-l>", "<C-w><C-l>", "Window: Move focus to the right")
map("<C-j>", "<C-w><C-j>", "Window: Move focus to the lower")
map("<C-k>", "<C-w><C-k>", "Window: Move focus to the upper")

--#endregion

--#region icons
-- Add extra icons and texts
wk.add({
  { "<leader>g", group = "Git", mode = { "n", "v" } },
  { "<leader>t", icon = "", group = "Tools", mode = { "n", "v" } },
  { "<leader>n", icon = "󱣱", group = "Navigation", mode = { "n", "v" } },
  { "<leader>c", group = "Code", mode = { "n", "x" } },
  { "<leader>d", group = "Document" },
  { "<leader>s", group = "Search", mode = { "n", "v" } },
  { "<leader>?", group = "Help", icon = { icon = "", color = "green" }, mode = { "n", "v" } },
  {
    "<leader>?w",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Keymaps (which-key)",
  },
  { "<leader>?c", ":Copilot help<CR>", desc = "Copilot: Help" },
  {
    "<leader>tb",
    desc = "Functions: My",
    function()
      print("Type of current file is " .. vim.bo.filetype)
    end,
  },
})
--#endregion
