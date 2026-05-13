-- vim: ts=2 sts=2 sw=2 et

return {
  { -- Snacks is a collection of plugins
    -- Snacks is a plugin that provides a lot of integrations for the most popular
    -- plugins, including lazygit, neogit, and gitsigns.
    --
    -- https://github.com/folke/lazy.nvim
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      lazygit = {
        -- your lazygit configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      dim = {},
      indent = {},
      notify = {},
    },
    config = function(_, opts)
      local snacks = require("snacks")
      snacks.setup(opts)
      --
      vim.keymap.set("n", "<leader>gl", snacks.lazygit.log_file, { desc = "Open LazyGit in current file" })
      vim.keymap.set("n", "<leader>gL", snacks.lazygit.open, { desc = "Open LazyGit" })
      --
      Snacks.toggle.dim():map("<leader>uD")
      Snacks.toggle.indent():map("<leader>ui")
      --
      Snacks.toggle.line_number():map("<leader>ul")
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
      --
      Snacks.toggle.diagnostics():map("<leader>ud")
      Snacks.toggle.inlay_hints():map("<leader>uh")
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
      --
      Snacks.toggle
        .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
        :map("<leader>uc")
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
      Snacks.toggle.treesitter():map("<leader>uT")
    end,
  },

  { -- BufferLine (TopBar)
    enabled = true,
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- load when editing files
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  { -- Oil
    "stevearc/oil.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
    config = function()
      require("oil").setup({
        default_file_explorer = true, -- start up nvim with oil instead of netrw
        columns = {},
        keymaps = {
          ["<C-h>"] = false,
          ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
          ["<M-h>"] = "actions.select_split",
          ["q"] = "actions.close",
        },
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
        },
        skip_confirm_for_simple_edits = true,
      })

      require("which-key").add({
        {
          "<leader>-",
          icon = { icon = State.icons.ui.Folder, color = "green" },
          mode = { "n" },
        },
        {
          "<leader>+",
          icon = { icon = State.icons.ui.Folder, color = "green" },
          mode = { "n" },
        },
      })

      vim.keymap.set("n", "<leader>+", "<CMD>Oil .<CR>", { desc = "Explorer (workspace)" })
      vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Explorer (cwd)" })

      -- open parent dir in float window
      -- vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil", -- Adjust if Oil uses a specific file type identifier
        callback = function()
          vim.opt_local.cursorline = true
        end,
      })
    end,
  },

  { -- LuaLine (Bottom Bar)
    enabled = true,
    -- https://www.nerdfonts.com/cheat-sheet
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
      },
    },
    config = function()
      local extra = require("utils.lualine")

      ---@diagnostic disable: different-requires
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "", -- { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
            },
            "nvim-dap-ui",
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              -- path = 4, -- filename and path (0:filename, 1:relative path)
              path = 0,
              symbols = { modified = " ", readonly = " " },
            },
            "%=", -- center text section
            {
              "navic",
              color_correction = "static",
              navic_opts = {
                highlight = true,
                depth_limit = 3,
                separator = "  ",
                click = true,
              },
              bg = "#ffffff",
            },
          },
          lualine_x = {
            "nvim-dap-ui",
            { -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_y = {
            -- "progress",
            -- "diagnostics",
            "quickfix",
            {
              "diagnostics",
              -- use a custom source: all workspace buffers
              sources = { extra.workspace_diagnostic },
              symbols = {
                error = State.icons.lsp.Error .. ":",
                warn = State.icons.lsp.Warning .. ":",
                info = State.icons.lsp.Info .. ":",
                hint = State.icons.lsp.Hint .. ":",
              },
              colored = true,
              update_in_insert = false,
            },
          },
          lualine_z = {
            "location",
            "filetype",
            "fileformat",
            { "encoding", separator = { right = "" }, left_padding = 2 },
            -- { clock, separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {
          "lazy",
          "man",
          "mason",
          "nvim-dap-ui",
          "nvim-tree",
          "quickfix",
          "symbols-outline",
        },
      })
    end,
  },

  { -- Markdown Preview
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    -- ft = { "markdown", "norg", "rmd", "org" },
    init = function()
      -- Define colors
      local color1_bg = "#ff757f"
      local color2_bg = "#4fd6be"
      local color3_bg = "#7dcfff"
      local color4_bg = "#ff9e64"
      local color5_bg = "#7aa2f7"
      local color6_bg = "#c0caf5"
      local color_fg = "#1F2335"
      -- -- Heading background
      vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
      vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
      vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
      vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s gui=bold]], color_fg, color4_bg))
      vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s gui=bold]], color_fg, color5_bg))
      vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s gui=bold]], color_fg, color6_bg))

      -- Heading fg
      -- vim.cmd(string.format([[highlight Headline1Fg guifg=%s gui=bold]], colors.color1_bg))
      -- vim.cmd(string.format([[highlight Headline2Fg guifg=%s gui=bold]], colors.color2_bg))
      -- vim.cmd(string.format([[highlight Headline3Fg guifg=%s gui=bold]], colors.color3_bg))
      -- vim.cmd(string.format([[highlight Headline4Fg guifg=%s gui=bold]], colors.color4_bg))
      -- vim.cmd(string.format([[highlight Headline5Fg guifg=%s gui=bold]], colors.color5_bg))
      -- vim.cmd(string.format([[highlight Headline6Fg guifg=%s gui=bold]], colors.color6_bg))
    end,
    opts = {
      heading = {
        sign = false,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        backgrounds = {
          "Headline1Bg",
          "Headline2Bg",
          "Headline3Bg",
          "Headline4Bg",
          "Headline5Bg",
          "Headline6Bg",
        },
        foregrounds = {
          "Headline1Fg",
          "Headline2Fg",
          "Headline3Fg",
          "Headline4Fg",
          "Headline5Fg",
          "Headline6Fg",
        },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      bullet = {
        -- Turn on / off list bullet rendering
        enabled = true,
      },
      -- checkbox = {
      --     -- Turn on / off checkbox state rendering
      --     enabled = true,
      --     -- Determines how icons fill the available space:
      --     --  inline:  underlying text is concealed resulting in a left aligned icon
      --     --  overlay: result is left padded with spaces to hide any additional text
      --     position = "inline",
      --     unchecked = {
      --         -- Replaces '[ ]' of 'task_list_marker_unchecked'
      --         icon = "   󰄱 ",
      --         -- Highlight for the unchecked icon
      --         highlight = "RenderMarkdownUnchecked",
      --         -- Highlight for item associated with unchecked checkbox
      --         scope_highlight = nil,
      --     },
      --     checked = {
      --         -- Replaces '[x]' of 'task_list_marker_checked'
      --         icon = "   󰱒 ",
      --         -- Highlight for the checked icon
      --         highlight = "RenderMarkdownChecked",
      --         -- Highlight for item associated with checked checkbox
      --         scope_highlight = nil,
      --     },
      -- },
    },
  },

  { -- Current Scope at Lualine
    "SmiteshP/nvim-navic",
    enabled = true,
    lazy = true,
    -- dependencies = { "neovim/nvim-lspconfig" },
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
  },

  { -- Legendary is a helper for commands and keymaps
    "mrjones2014/legendary.nvim",
    enabled = true,
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>hl",
        "<cmd>Legendary<cr>",
        { desc = "Legendary: Nvim cheatsheet", noremap = true, silent = true }
      )
    end,
  },

  { -- When doing ShowKeysToggle enable a float window showing commands
    "nvzone/showkeys",
    enabled = true,
    cmd = "ShowkeysToggle",
    opts = {
      -- position = "bottom-right",
      maxkeys = 3,
      show_count = true,
      winopts = {
        focusable = false,
        relative = "editor",
        style = "minimal",
        border = "single",
        height = 1,
        row = 1,
        col = 0,
      },
    },
  },

  { -- Start page
    "goolord/alpha-nvim",
    config = function()
      local theme = require("alpha.themes.startify")

      local draw = require("utils.drawings")

      theme.section.header.val = draw.duck
      theme.section.header.opts.position = "center"

      require("alpha").setup(theme.config)
    end,
  },

  { -- TODO helpers
    -- BUG:
    -- FIX:
    -- FIXME:
    -- HACK:
    -- INFO:
    -- NOTE:
    -- OPTIM:
    -- OPTIMIZE:
    -- PERF:
    -- PERFORMANCE:
    -- TESTING:
    -- FAILED:
    -- PASSED:
    -- TODO:
    -- WARN:
    -- WARNING:
    -- XXX:
    -- IDEA:
    -- CHECK:
    -- REVIEW:
    -- ASK:
    -- QUESTION:

    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      { "<leader>ct", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      {
        "<leader>cT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    config = function()
      -- vim.keymap.set(
      --   "n",
      --   "<leader>st",
      --   "<cmd>TodoTelescope<cr>",
      --   { desc = "TODO: telescope todos search", noremap = true, silent = true }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<leader>ct",
      --   "<cmd>TodoQuickFix<CR>",
      --   { desc = "TODO: Quickfix panel", noremap = true, silent = true }
      -- )

      local todo = require("todo-comments")
      todo.setup({
        keywords = {
          REVIEW = { icon = "", color = "hint", alt = { "CHECK" } },
          IDEA = { icon = "", color = "info", alt = { "THEORY" } },
          QUESTION = { icon = "󱜺", color = "warning", alt = { "ASK" } },
        },
      })
    end,
  },

  { -- Noice is a float notifier and used by lualine too
    -- TIP: Type `:Noice` to see all available options
    "folke/noice.nvim",
    dependencies = { "rcarriga/nvim-notify" },
    enabled = true,
    event = "VeryLazy",
    opts = {
      notify = {
        enbled = true,
        view = "notify",
      },
      cmdline = {
        enabled = true,
        view = "cmdline", -- use a classic cmdline view
        format = {
          cmdline = { icon = State.icons.ui.Command }, -- icon for the cmdline
          search_down = { icon = State.icons.ui.Search .. " " .. State.icons.ui.SearchDown },
          search_up = { icon = State.icons.ui.Search .. " " .. State.icons.ui.SearchUp },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)

      vim.notify = require("notify")

      require("telescope").load_extension("noice")
    end,
  },

  { -- WhichKey is a useful plugin to show you pending keybinds.
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    "folke/which-key.nvim",
    enabled = true,
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

  { -- Theme
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

      -- Yank highlight
      vim.api.nvim_set_hl(0, "Search", { bg = "#ffcc00", fg = "#000000" })

      -- Search highlight
      vim.api.nvim_set_hl(0, "Search", { bg = "#ffcc00", fg = "#000000" })

      -- Visual selection highlight
      vim.api.nvim_set_hl(0, "Visual", { bg = "#005f87", fg = "#ffffff" })

      -- Cursor line highlight
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1c1c1c" })
    end,
  },

  -- {
  --   "rebelot/kanagawa.nvim",
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
  --     vim.cmd.colorscheme("material-darker")
  --     vim.cmd.colorscheme("material-palenight")
  --     vim.cmd.colorscheme("tokyodark")
  --     vim.cmd.colorscheme("rose-pine-moon")
  --     vim.cmd.colorscheme("dracula")
  --     vim.cmd.colorscheme("dracula-soft")
  --     vim.cmd.colorscheme("catppuccin-mocha")
  --   end,
  -- }

  -- {
  --     "ViViDboarder/wombat.nvim",
  --     dependencies = { { "rktjmp/lush.nvim" } },
  --     opts = {
  --         -- You can optionally specify the name of the ansi colors you wish to use
  --         -- This defaults to nil and will use the default ansi colors for the theme
  --         ansi_colors_name = nil,
  --     },
  -- }
}
