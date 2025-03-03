-- return {
--   { -- You can easily change to a different colorscheme.
--     -- Change the name of the colorscheme plugin below, and then
--     -- change the command in the config to whatever the name of that colorscheme is.
--     --
--     -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
--     'folke/tokyonight.nvim',
--     priority = 1000, -- Make sure to load this before all the other start plugins.
--     init = function()
--       -- Load the colorscheme here.
--       -- Like many other themes, this one has different styles, and you could load
--       -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--       vim.cmd.colorscheme 'tokyonight-night'

--       -- You can configure highlights by doing something like:
--       vim.cmd.hi 'Comment gui=none'
--     end,
--   },
-- }



-- Monokai
-- return {
--     {
--         "polirritmico/monokai-nightasty.nvim",
--         lazy = false,
--         priority = 1000,
--     }
-- }

-- lua/plugins/rose-pine.lua
-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     config = function()
--         vim.cmd("colorscheme rose-pine")
--     end
-- }

-- Catppuccin
-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000
-- }

-- return {
--     "ViViDboarder/wombat.nvim",
--     dependencies = { { "rktjmp/lush.nvim" } },
--     opts = {
--         -- You can optionally specify the name of the ansi colors you wish to use
--         -- This defaults to nil and will use the default ansi colors for the theme
--         ansi_colors_name = nil,
--     },
-- }

-- tokyonight
return {

  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme tokyonight")
  end
}

-- Dracula
-- return {
--     {
--         "Mofiqul/dracula.nvim",
--         config = function()
--             vim.cmd("colorscheme dracula")
--         end
--     },
-- }

-- vim: ts=2 sts=2 sw=2 et
