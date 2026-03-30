-- vim: ts=2 sts=2 sw=2 et

-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
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

      map("<leader>ss", builtin.live_grep, "Find by Grep")
      map("<leader>sS", telescope.extensions.live_grep_args.live_grep_args, "Find by Grep with args")
      map("<leader>s*", builtin.grep_string, "Workspace search word under cursor")
      map("<leader>?h", builtin.help_tags, "Help for Neovim plugins")
      map("<leader>?t", "<cmd> Telescope <cr>", "Overview")
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
      map("<leader>tt", builtin.colorscheme, "Theme switch")
      map("<leader>gS", builtin.git_stash, "Search Stash")
      map("<leader>gb", builtin.git_branches, "Search Branches")
      map("<leader>gf", builtin.git_files, "Search Files")
      map("<leader>gs", builtin.git_status, "Search Status")
      map("<leader>gC", builtin.git_commits, "Search ALL Commits")
      map("<leader>gc", extra.find_commits, "Search Commits in current buffer")
      map("<leader>gc", extra.find_commits_range, "Search Commits in current visual selection", "v")
      map("<leader>sb", builtin.buffers, "Search openned buffers")
    end,
  },
}
