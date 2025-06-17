-- vim: ts=2 sts=2 sw=2 et

-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
return {
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },

      -- Document existing key chains
      -- spec = {
      -- 	{ "<leader>c", group = " Code", mode = { "n", "x" } },
      -- 	{ "<leader>d", group = "󱔗 Document" },
      -- 	{ "<leader>r", group = " Rename" },
      -- 	{ "<leader>s", group = " Search" },
      -- 	{ "<leader>w", group = "[W]orkspace" },
      -- 	{ "<leader>t", group = "[T]oggle" },
      -- 	{ "<leader>h", group = " Git [H]unk", mode = { "n", "v" } },

      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,

          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },

          -- Custom
          { "<leader>g", group = "Git", mode = { "n", "v" } },
          { "<leader>t", icon = { icon = "", color = "blue" }, group = "Tools", mode = { "n", "v" } },
          { "<leader>n", icon = { icon = "󱣱", color = "green" }, group = "Navigation", mode = { "n", "v" } },
          { "<leader>c", group = "Code", mode = { "n", "x" } },
          { "<leader>d", group = "Document" },
          { "<leader>s", group = "Search", mode = { "n", "v" } },
          { "<leader>h", group = "Help", icon = { icon = "", color = "green" }, mode = { "n", "v" } },
          {
            "<leader>hw",
            function()
              require("which-key").show({ global = false })
            end,
            desc = "Keymaps (which-key)",
          },
          { "<leader>hc", ":Copilot help<CR>", desc = "Copilot: Help" },
          {
            "<leader>tb",
            desc = "Functions: My",
            function()
              print("Type of current file is " .. vim.bo.filetype)
            end,
          },
        },
      },
    },
  },
}
