-- vim: ts=2 sts=2 sw=2 et

-- Shortcut to toggle comment lines based on language
-- type gcc or gc to toggle, or ctrl+/
return {
  {
    "tpope/vim-commentary",
    event = "VeryLazy",
    options = {},
    priority = 80,
    config = function()
      -- alternativaly, u can use gcc
      vim.keymap.set("i", "<C-_>", "<cmd>Commentary<CR>", { silent = true, desc = "Comment" })
    end,
  },
}
