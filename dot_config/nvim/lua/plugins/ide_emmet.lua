return {
  -- here only for wrapping html tags
  -- emmet_ls is already installed in mason
  "olrtg/nvim-emmet",
  event = "VeryLazy",
  config = function()
    vim.keymap.set({ "n", "v" }, '<leader>ce', require('nvim-emmet').wrap_with_abbreviation,
      { desc = "Wrap with Emmet abbreviation" })
  end,
}
