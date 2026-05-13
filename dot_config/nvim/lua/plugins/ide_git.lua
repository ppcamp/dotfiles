-- vim: ts=2 sts=2 sw=2 et

return {
  { -- GitSigns support (with line blame, change color)
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
      map("n", "<leader>gy", function()
        local row = vim.fn.line(".")
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.fnamemodify(file, ":h")
        local gitcmd = string.format(
          "git -C %s blame -L %d,%d -s -- %s",
          vim.fn.shellescape(dir),
          row,
          row,
          vim.fn.shellescape(file)
        )
        local out = vim.fn.system(gitcmd)
        out = out:gsub("^.-\n", "", 1) -- remove stty line
        --
        local hash = out:match("^(%w+)")
        if hash and hash ~= string.rep("0", 40) then
          vim.fn.setreg("+", hash)
          vim.fn.setreg('"', hash)
          vim.notify("Yanked commit: " .. hash, vim.log.levels.INFO)
        else
          vim.notify("Line not committed", vim.log.levels.WARN)
        end
      end, "Yank commit hash for line")
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
      map("n", "<leader>ghh", gitsigns.refresh, "Refresh")
      map("n", "<leader>gb", gitsigns.blame, "Blame file")
      map("n", "<leader>gB", function()
        gitsigns.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>gq", function()
        gitsigns.setqflist("all")
      end, "Set quickfix list")
      map("n", "<leader>gP", gitsigns.preview_hunk, "Preview hunk")
      map("n", "<leader>gp", gitsigns.preview_hunk_inline, "Preview hunk inline")
      -- map("n", "<leader>gQ", gitsigns.setqflist, "Set quickfix list (current file)")
      --
      -- Toggles
      map("n", "<leader>gtw", gitsigns.toggle_word_diff, "Toggle word diff")
      map("n", "<leader>gtd", gitsigns.toggle_current_line_blame, "Toggle virtual blame")
      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
      map("n", "<leader>gd", gitsigns.diffthis, "Diff this")
      map("n", "<leader>gD", function()
        gitsigns.diffthis("~")
      end, "Diff this against working directory")
      --
      require("which-key").add({
        { "<leader>gh", mode = { "n", "v" }, group = "Actions" },
        { "<leader>gt", mode = { "n", "v" }, group = "Toggle actions" },
      })
      -- ]c - next hunk
      -- [c - prev hunk
    end,
  },
}
