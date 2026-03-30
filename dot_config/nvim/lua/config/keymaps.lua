-- vim: ts=2 sts=2 sw=2 et

State.map("<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")
State.map("<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode", "t")
State.map("<leader>%", ":vsplit<CR>", { desc = "Split vertically", icon = State.icons.ui.VerticalSplit })
State.map("<leader>e", ":enew<CR>", { desc = "New buffer", icon = State.icons.ui.File })
State.map("jk", "<Esc>", "Exit from edit mode", { "i" })
State.map(";", ":", "CMD enter command mode")
State.map("<C-s>", "<cmd> w <cr>", { desc = "Save", silent = true }, { "n", "i", "v" })

-- quit works for buffers/quickfix panels (for splits, use ctrl+w q )
State.map("<C-q>", ":bd<CR>", "While in insert mode, when hit Ctrl+Q, will close the current buffer")
State.map("<Tab>", ":bnext<CR>", "While hit tab, will change to next buffer")
State.map("<S-Tab>", ":bprevious<CR>", "While hit Shift+tab, will change to next buffer")
State.map("<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer")
State.map("<leader>bd", "<cmd>:bd<cr>", "Delete Buffer")
State.map("<leader>bo", "<cmd>:%bd | e# | bd#<cr>", "Delete Other Buffers")
State.map("<leader>bD", "<cmd>:bd|close<cr>", "Delete Buffer and Window")

-- Keybinds to make split navigation easier.
State.map("<C-h>", "<C-w><C-h>", "Window: Move focus to the left")
State.map("<C-l>", "<C-w><C-l>", "Window: Move focus to the right")
State.map("<C-j>", "<C-w><C-j>", "Window: Move focus to the lower")
State.map("<C-k>", "<C-w><C-k>", "Window: Move focus to the upper")
