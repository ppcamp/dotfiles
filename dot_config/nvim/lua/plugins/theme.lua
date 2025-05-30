-- vim: ts=2 sts=2 sw=2 et

return {
  "rebelot/kanagawa.nvim",
  -- "marko-cerovac/material.nvim",
  -- "tiagovla/tokyodark.nvim",

  -- "catppuccin/nvim",
  -- "Mofiqul/dracula.nvim",
  -- "rose-pine/neovim",

  priority = 1000,
  config = function()
    vim.cmd.colorscheme("kanagawa")
    -- NOTE: default that doesn't need to install extra
    -- habamax
    -- sorbet
    -- slat
    -- lunaperche
    -- retrobox
    -- desert
    -- minischeme
    -- wildcharm
    -- wildcharm
    -- vim

    -- vim.cmd.colorscheme("material-darker")
    -- vim.cmd.colorscheme("material-palenight")
    -- vim.cmd.colorscheme("tokyodark")

    -- vim.cmd.colorscheme("rose-pine-moon")
    -- vim.cmd.colorscheme("dracula")
    -- vim.cmd.colorscheme("dracula-soft")
    -- vim.cmd.colorscheme("catppuccin-mocha")
  end,
}

-- return {
--     "ViViDboarder/wombat.nvim",
--     dependencies = { { "rktjmp/lush.nvim" } },
--     opts = {
--         -- You can optionally specify the name of the ansi colors you wish to use
--         -- This defaults to nil and will use the default ansi colors for the theme
--         ansi_colors_name = nil,
--     },
-- }
