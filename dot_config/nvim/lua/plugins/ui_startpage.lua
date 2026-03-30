-- vim: ts=2 sts=2 sw=2 et

return {
  "goolord/alpha-nvim",
  config = function()
    local theme = require("alpha.themes.startify")

    local draw = require("utils.drawings")

    theme.section.header.val = draw.duck
    theme.section.header.opts.position = "center"

    require("alpha").setup(theme.config)
  end,
}
