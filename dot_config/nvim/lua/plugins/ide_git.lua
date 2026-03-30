-- vim: ts=2 sts=2 sw=2 et

return {
  -- GitSigns support (with line blame, change color)
  {
    "lewis6991/gitsigns.nvim",
    priority = 100,
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        word_diff = true,
        current_line_blame_formatter = "[<author>, <author_time:%R>] <summary>",
      })

      --- Other configs
      local function map(mode, l, r, descr)
        local opts = {}
        opts.desc = "Git: " .. descr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next hunk")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous hunk")

      -- Actions
      map("n", "<leader>ghs", gitsigns.stage_hunk, "Stage hunk")
      map("n", "<leader>ghr", gitsigns.reset_hunk, "Reset hunk")

      map("v", "<leader>ghs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")

      map("v", "<leader>ghr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset hunk")

      map("n", "<leader>ghS", gitsigns.stage_buffer, "Stage buffer")
      map("n", "<leader>ghR", gitsigns.reset_buffer, "Reset buffer")
      map("n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk")
      map("n", "<leader>ghi", gitsigns.preview_hunk_inline, "Preview hunk inline")
      map("n", "<leader>ghh", gitsigns.refresh, "Refresh")

      map("n", "<leader>ghb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame line")

      map("n", "<leader>gq", function() gitsigns.setqflist("all") end, "Set quickfix list")
      -- map("n", "<leader>gQ", gitsigns.setqflist, "Set quickfix list (current file)")

      -- Toggles
      map("n", "<leader>gho", gitsigns.toggle_current_line_blame, "Toggle current line blame")
      map("n", "<leader>ghT", gitsigns.toggle_deleted, "Toggle deleted")
      map("n", "<leader>ght", gitsigns.toggle_word_diff, "Toggle word diff")

      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")

      map("n", "<leader>ghd", gitsigns.diffthis, "Diff this")
      map("n", "<leader>ghD", function()
        gitsigns.diffthis("~")
      end, "Diff this against working directory")

      require("which-key").add({ { "<leader>gh", mode = { "n", "v" }, group = "Hunk actions" } })

      -- ]c - next hunk
      -- [c - prev hunk

      map("n", "<leader>ghc", ":only<CR>", "Close window")
    end,
  },
  -- {
  --   "gitsigns.nvim",
  --   opts = function()
  --     Snacks.toggle({
  --       name = "Git Signs",
  --       get = function()
  --         return require("gitsigns.config").config.signcolumn
  --       end,
  --       set = function(state)
  --         require("gitsigns").toggle_signs(state)
  --       end,
  --     }):map("<leader>uG")
  --   end,
  -- },
  {
    "sindrets/diffview.nvim",
    priority = 10,
    config = function()
      require("diffview").setup()

      local map = function(lhs, rhs, mode, opts)
        opts = opts or {}
        mode = mode or "n"
        opts.silent = true
        opts.noremap = true
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      end

      map("<leader>gdd", "<cmd>DiffviewOpen<CR>")
      map("<leader>gdD", "<cmd>DiffviewClose<CR>")
      map("<leader>gdr", "<cmd>DiffviewRefresh<CR>")
      map("<leader>gdv", "<cmd>DiffviewToggleFiles<CR>")
      map("<leader>gdp", "<cmd>DiffviewFileHistory %<CR>")

      require("which-key").add({
        { "<leader>gd", desc = "DiffView" },
        -- { "<leader>gD", desc = "DiffView: Close" },
        -- { "<leader>gr", desc = "DiffView: Refresh" },
        -- { "<leader>gv", desc = "DiffView: Toggle Files" },
        -- { "<leader>gp", desc = "DiffView: File History" },
      })
    end,
  },
}
