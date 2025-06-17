-- vim: ts=2 sts=2 sw=2 et

-- Nvim startpage

return {
  "goolord/alpha-nvim",
  priority = 900,
  config = function()
    local theme = require("alpha.themes.startify").config
    require("alpha").setup(theme)
  end,
}
