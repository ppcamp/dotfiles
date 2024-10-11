
-- Setup lazy.nvim (import all plugins under "plugins" directory)
-- https://lazy.folke.io/installation
require("lazy").setup({
    spec = {
      -- import your plugins
      { import = "plugins" },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },


    -- automatically check for plugin updates
    checker = { enabled = false },
  })

  -- vim: ts=2 sts=2 sw=2 et
