-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')



-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })



-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local wk = require("which-key")

wk.add({
  { "<leader>f", group = " Completions"}, -- group
  { "<leader>fn", desc = "<C-n> Select the [n]ext item" },
  { "<leader>fp", desc = "<C-p> Select the [p]revious item" },
  { "<leader>fb", desc = "<C-b> Scroll the documentation window [b]ack" },
  { "<leader>ff", desc = "<C-f> Scroll the documentation window [f]orward" },
  { "<leader>fy", desc = "<C-y> Accept ([y]es) the completion" },
  { "<leader>fs", desc = "<C-Space> Manually trigger a completion from nvim-cmp" },

  { "<leader>z", group = " Tools"},
  { "<leader>zb", function() print("hello") end, desc = "Foobar" },
--   { "<leader>f1", hidden = true }, -- hide this keymap
--   { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
--   { "<leader>b", group = "buffers", expand = function()
--       return require("which-key.extras").expand.buf()
--     end
--   },
})
