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
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },

      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require("telescope")

      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      telescope.setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
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

      map("<leader>sc", "<cmd> Telescope commands<cr>", "Commands")
      map("<leader>sk", builtin.keymaps, "Keymaps")
      map("<leader>sp", function()
        builtin.man_pages({ sections = { "ALL" } })
      end, "Man pages")
      map("<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, "Telescope search Neovim files")
      map("<leader>sg", function()
        builtin.live_grep({
          prompt_title = "Search words in GOROOT/src",
          cwd = vim.api.nvim_exec("GoRoot", true) .. "/src",
        })
      end, "Telescope search inside golang files")
      map("<leader>sG", function()
        builtin.live_grep({
          prompt_title = "Search files in GOROOT/src",
          cwd = vim.api.nvim_exec("GoRoot", true),
        })
      end, "Telescope search golang files")


      map("<leader>sf", builtin.find_files, "Find Files")
      map("<leader>s*", builtin.grep_string, "Workspace search word under cursor")
      -- map("<leader>ss", builtin.live_grep, "Find by Grep")
      map("<leader>sS", telescope.extensions.live_grep_args.live_grep_args, "Find by Grep with args")
      map("<leader>ss", builtin.live_grep, "Find by Grep")
      map("<leader>sF", builtin.oldfiles, "Find Recent Files")
      map("<leader>sr", builtin.resume, "Redo last search")
      map("<leader>sm", builtin.marks, "Find in all marks")
      map("<leader>sR", builtin.registers, "Show registers values")

      map("<leader>tt", builtin.colorscheme, "Theme switch")

      --- Search related
      map("<leader>gS", builtin.git_stash, "Search Stash")
      map("<leader>gC", builtin.git_commits, "Search ALL Commits")
      map("<leader>gb", builtin.git_branches, "Search Branches")
      map("<leader>gf", builtin.git_files, "Search Files")
      map("<leader>gs", builtin.git_status, "Search Status")
      map("<leader>gc", builtin.git_bcommits, "Search Commits in current buffer")
      map("<leader>gc", function()
        -- Get the start and end positions of the visual selection
        local _, start_line, _, _ = unpack(vim.fn.getpos("v"))
        local _, end_line, _, _ = unpack(vim.fn.getpos("."))

        builtin.git_bcommits_range({
          prompt_title = "Search Commits in current range",
          multi_select = true,
          from = start_line,
          to = end_line,
        })
      end, "Search Commits in current visual selection", "v")

      -- Slightly advanced example of overriding default behavior and theme
      -- map("<leader>/", function()
      -- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
      -- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      -- 		-- winblend = 10,
      -- 		previewer = false,
      -- 	}))
      -- end, "Search in current buffer")

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- map("<leader>s/", function()
      -- 	builtin.live_grep({
      -- 		grep_open_files = true,
      -- 		prompt_title = "Live Grep in Open Files",
      -- 	})
      -- end, "Search / in Open Files")

      map("<leader>sb", builtin.buffers, "Search openned buffers")
    end,
  },
}
