-- vim: ts=2 sts=2 sw=2 et

return {
  "sainnhe/gruvbox-material",
  enabled = true,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_foreground = "mix"
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_float_style = "bright"
    vim.g.gruvbox_material_statusline_style = "material"
    vim.g.gruvbox_material_cursor = "auto"
    vim.cmd.colorscheme("gruvbox-material")
  end,
}

-- return {
--   -- "rebelot/kanagawa.nvim",
--   "marko-cerovac/material.nvim",
--   enabled = true,
--   -- "tiagovla/tokyodark.nvim",
--   -- "catppuccin/nvim",
--   -- "Mofiqul/dracula.nvim",
--   -- "rose-pine/neovim",
--   -- "ViViDboarder/wombat.nvim",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("material-darker")
--     -- NOTE: default that doesn't need to install extra
--     -- habamax
--     -- sorbet
--     -- slat
--     -- lunaperche
--     -- retrobox
--     -- desert
--     -- minischeme
--     -- wildcharm
--     -- wildcharm
--     -- vim

--     -- vim.cmd.colorscheme("material-darker")
--     -- vim.cmd.colorscheme("material-palenight")
--     -- vim.cmd.colorscheme("tokyodark")

--     -- vim.cmd.colorscheme("rose-pine-moon")
--     -- vim.cmd.colorscheme("dracula")
--     -- vim.cmd.colorscheme("dracula-soft")
--     -- vim.cmd.colorscheme("catppuccin-mocha")
--   end,
-- }

-- -- return {
-- --     "ViViDboarder/wombat.nvim",
-- --     dependencies = { { "rktjmp/lush.nvim" } },
-- --     opts = {
-- --         -- You can optionally specify the name of the ansi colors you wish to use
-- --         -- This defaults to nil and will use the default ansi colors for the theme
-- --         ansi_colors_name = nil,
-- --     },
-- -- }
