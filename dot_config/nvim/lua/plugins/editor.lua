-- vim: ts=2 sts=2 sw=2 et

return {
  { -- Bigfile
    -- Bigfile is a plugin that allows you to open files larger than the
    -- maximum file size supported by Neovim.
    --
    -- https://github.com/LunarVim/bigfile.nvim
    "LunarVim/bigfile.nvim",
  },

  { -- autopairs
    -- Generate a matching pair for braces{}, parenthesis(), square bracket[], and so goes on.
    -- https://github.com/windwp/nvim-autopairs
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    -- Optional dependency
    priority = 70,
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- enable treesitter integration
        disable_filetype = { "TelescopePrompt", "vim" },
        enable_afterquote = true, -- auto close after quote
      })

      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  { -- Delect tabstop and shiftwidth automatically
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    event = "BufReadPost",
    priority = 70,
  },

  { -- Multiple cursors in Neovim
    "mg979/vim-visual-multi",
    branch = "master",
  },

  { -- Allow to repeat custom mappings by typing "."
    "tpope/vim-repeat",
    event = "BufReadPost",
  },

  { -- Fast cursor move
    "xiyaowong/fast-cursor-move.nvim",
  },

  { -- search/replace in multiple files
    -- {
    --   -- A search panel and replacer for multi files
    --   -- https://github.com/nvim-pack/nvim-spectre
    --   "nvim-pack/nvim-spectre",
    -- },
    {
      "MagicDuck/grug-far.nvim",
      opts = { headerMaxWidth = 80 },
      cmd = "GrugFar",
      keys = {
        {
          "<leader>r",
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            })
          end,
          mode = { "n", "v" },
          desc = "Search and Replace",
        },
      },
    },
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      -- Better Around/Inside textobjects
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      --  - ci`  - [C]hange [I]nside [`]backtick
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
      require("mini.ai").setup(opts)
      --
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
      --
      -- This plugin also enable ci`, di`, ca`, da` and so on
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- add            = 'sa', to Add surrounding in Normal and Visual modes
      -- delete         = 'sd', to Delete surrounding
      -- find           = 'sf', to Find surrounding (to the right)
      -- find_left      = 'sF', to Find surrounding (to the left)
      -- highlight      = 'sh', to Highlight surrounding
      -- replace        = 'sr', to Replace surrounding
      -- update_n_lines = 'sn', to Update `n_lines`
      -- suffix_last    = 'l',  to Suffix to search with "prev" method
      -- suffix_next    = 'n',  to Suffix to search with "next" method
      --
      -- sai(" to add surrounding in everything inside the parentheses
      require("mini.surround").setup()
      --
      -- Add/Remove indentation
      -- gas to -> align text like below
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
      --
      -- Press s                to enter split Lua pattern.
      -- Press j                to choose justification side from available ones ("left", "center", "right", "none").
      -- Press m                to enter merge delimiter.
      -- Press f                to enter filter Lua expression               to configure which parts will be affected (like "align only first column").
      -- Press i                to ignore some commonly unwanted split matches.
      -- Press p                to pair neighboring parts so they be aligned together.
      -- Press t                to trim whitespace from parts.
      -- Press <BS> (backspace) to delete some last pre-step.
      require("mini.align").setup()
      --
      -- Move using alt+hjkl keys
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
      --
      require("mini.move").setup()
      -- Add animations to scroll, window resizing, and other actions
      -- require("mini.animate").setup()
      --
      -- Add notification plugin popup
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-notify.md
      -- require("mini.notify").setup({})
    end,
  },

  { -- Just add annotations to the current line accordding to the mark
    --    mx              Set mark x
    --    m,              Set the next available alphabetical (lowercase) mark
    --    m;              Toggle the next available mark at the current line
    --    dmx             Delete mark x
    --    dm-             Delete all marks on the current line
    --    dm<space>       Delete all marks in the current buffer
    --    m]              Move to next mark
    --    m[              Move to previous mark
    --    m:              Preview mark. This will prompt you for a specific mark to
    --                    preview; press <cr> to preview the next mark.
    --
    --    m[0-9]          Add a bookmark from bookmark group[0-9].
    --    dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    --    m}              Move to the next bookmark having the same type as the bookmark under
    --                    the cursor. Works across buffers.
    --    m{              Move to the previous bookmark having the same type as the bookmark under
    --                    the cursor. Works across buffers.
    --    dm=             Delete the bookmark under the cursor.
    --
    -- :delm        <mark> Delete the mark under the cursor.
    -- :delm!       <mark> Delete the mark under the cursor and all marks on the current line.
    -- :delm#       <mark> Delete all marks in the current buffer.
    -- :delm<space> <mark> Delete all marks in the current buffer.
    -- :delmarks    <mark> (same as :delm)
    -- :marks       <mark> Show all marks
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("marks").setup(opts)
      -- vim.keymap.set("n", "<leader>m", "<cmd>MarksListAll<cr>", { desc = "Toggle marks" })
    end,
  },

  { -- Telescope is a highly extendable fuzzy finder ui using fzf.
    -- The dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- Use the `dependencies` key to specify the dependencies of a particular plugin
    { -- Fuzzy Finder (files, lsp, etc)
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      branch = "master", -- "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
          "nvim-telescope/telescope-fzf-native.nvim",
          -- `build` is used to run some command when the plugin is installed/updated.
          -- This is only run then, not every time Neovim starts up.
          build = "make",
          -- `cond` is a condition used to determine whether this plugin should be
          -- installed and loaded.
          cond = function()
            return vim.fn.executable("make") == 1
          end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        {
          "nvim-telescope/telescope-live-grep-args.nvim",
          -- This will not install any breaking changes.
          -- For major updates, this must be adjusted manually.
          version = "^1.0.0",
        },
      },
      config = function()
        local telescope = require("telescope")
        -- See `:help telescope` and `:help telescope.setup()`
        telescope.setup({
          defaults = {
            horizontal = {
              height = 0.9,
              preview_cutoff = 120,
              prompt_position = "bottom",
              width = 0.9,
            },
            vertical = {
              height = 0.9,
              preview_cutoff = 40,
              prompt_position = "bottom",
              width = 0.9,
            },
          },
        })
        -- Enable Telescope extensions if they are installed
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        local extra = require("utils.telescope-functions")
        ---Alternative to map
        ---@param keys string
        ---@param func function | string
        ---@param desc string
        ---@param mode string?
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { desc = "Telescope: " .. desc })
        end
        map("<leader>?h", builtin.help_tags, "Help for Neovim plugins")
        map("<leader>?t", "<cmd> Telescope <cr>", "Overview")
        --
        map("<leader>tt", builtin.colorscheme, "Theme switch")
        --
        map("<leader>ss", builtin.live_grep, "Find by Grep")
        map("<leader>sS", telescope.extensions.live_grep_args.live_grep_args, "Find by Grep with args")
        map("<leader>s*", builtin.grep_string, "Workspace search word under cursor")
        map("<leader>sc", "<cmd> Telescope commands<cr>", "Commands")
        map("<leader>sk", builtin.keymaps, "Keymaps")
        map("<leader>sp", extra.find_man_pages, "Man pages")
        map("<leader>sn", extra.find_files, "Telescope search Neovim files")
        map("<leader>sg", extra.find_golang_text_files, "Telescope search inside golang files")
        map("<leader>sG", extra.find_golang_files, "Telescope search golang files")
        map("<leader>sf", builtin.find_files, "Find Files")
        map("<leader>sF", builtin.oldfiles, "Find Recent Files")
        map("<leader>sr", builtin.resume, "Redo last search")
        map("<leader>sm", builtin.marks, "Find in all marks")
        map("<leader>sR", builtin.registers, "Show registers values")
        map("<leader>sb", builtin.buffers, "Search openned buffers")
        --
        -- map("<leader>gS", builtin.git_stash, "Search Stash")
        -- map("<leader>gb", builtin.git_branches, "Search Branches")
        -- map("<leader>gf", builtin.git_files, "Search Files")
        -- map("<leader>gs", builtin.git_status, "Search Status")
        -- map("<leader>gC", builtin.git_commits, "Search ALL Commits")
        -- map("<leader>gc", extra.find_commits, "Search Commits in current buffer")
        -- map("<leader>gc", extra.find_commits_range, "Search Commits in current visual selection", "v")
      end,
    },
  },

  { -- Better F keys
    -- Flash enhances the built-in search functionality by showing labels
    -- at the end of each match, letting you quickly jump to a specific
    -- location.
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "f",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "F",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
}
