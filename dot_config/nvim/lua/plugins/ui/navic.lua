-- vim: ts=2 sts=2 sw=2 et

return {
  "SmiteshP/nvim-navic",
  enabled = true,
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local navic = require("nvim-navic")
    navic.setup({
      lsp = {
        auto_attach = true,
      },
    })

    -- To be able to print at the top
    --
    -- vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
    --  OR
    -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
}
