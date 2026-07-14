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
        local cmd = {
          "git",
          "-C",
          dir,
          "blame",
          "-L",
          string.format("%d,%d", row, row),
          "--porcelain",
          "--",
          file,
        }
        --
        local out = vim.system(cmd, { text = true }):wait() -- runs in system bg, thus no tty.
        if out.code ~= 0 then
          vim.notify(out.stderr, vim.log.levels.ERROR)
        end
        --
        local hash = (out.stdout or ""):match("^(%w+)")
        if hash and hash ~= string.rep("0", 40) then
          vim.fn.setreg("+", hash)
          vim.fn.setreg('"', hash)
          vim.notify("Yanked commit: " .. hash, vim.log.levels.INFO)
        else
          vim.notify("Line not committed", vim.log.levels.WARN)
        end
      end, "Yank commit hash for line")
      -- Actions
      map("n", "<leader>ga", gitsigns.stage_hunk, "Stage hunk")
      map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")
      map("v", "<leader>ga", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")
      map("v", "<leader>gr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset hunk")
      map("n", "<leader>gA", gitsigns.stage_buffer, "Stage buffer")
      map("n", "<leader>gR", gitsigns.reset_buffer, "Reset buffer")
      map("n", "<leader>gh", gitsigns.refresh, "Refresh")
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
      map("n", "<leader>gl", function()
        local row = vim.fn.line(".")
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.fnamemodify(file, ":h")
        local cmd = {
          "git",
          "-C",
          dir,
          "blame",
          "-L",
          string.format("%d,%d", row, row),
          "--porcelain",
          "--",
          file,
        }
        local out = vim.system(cmd, { text = true }):wait()
        if out.code ~= 0 then
          vim.notify(out.stderr, vim.log.levels.ERROR)
          return
        end
        local hash = (out.stdout or ""):match("^(%w+)")
        if hash and hash ~= string.rep("0", 40) then
          vim.system({ "lazygit", "-p", dir, "-r", hash }, { cwd = dir })
        else
          vim.notify("Line not committed", vim.log.levels.WARN)
        end
      end, "Open lazygit at current commit")
      map("v", "<leader>gl", function()
        local start_line = vim.fn.line("v")
        local end_line = vim.fn.line(".")
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.fnamemodify(file, ":h")
        local cmd = {
          "git",
          "-C",
          dir,
          "log",
          "--oneline",
          "-p",
          string.format("-L%d,%d:%s", start_line, end_line, file),
        }
        local out = vim.system(cmd, { text = true }):wait()
        if out.code ~= 0 then
          vim.notify(out.stderr, vim.log.levels.ERROR)
          return
        end
        local entries = {}
        for line in (out.stdout or ""):gmatch("[^\n]+") do
          if line:match("^%x+%s") then
            table.insert(entries, { filename = file, text = line })
          end
        end
        if #entries > 0 then
          vim.fn.setqflist(entries, "r")
          vim.cmd("copen")
        else
          vim.notify("No commits in range", vim.log.levels.WARN)
        end
      end, "Show commits in range")
      map("n", "<leader>gbl", function()
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.fnamemodify(file, ":h")
        local cmd = {
          "git",
          "-C",
          dir,
          "blame",
          "-l",
          "--",
          file,
        }
        local out = vim.system(cmd, { text = true }):wait()
        if out.code ~= 0 then
          vim.notify(out.stderr, vim.log.levels.ERROR)
          return
        end
        local entries = {}
        for i, line in ipairs(vim.split(out.stdout or "", "\n")) do
          if line ~= "" then
            table.insert(entries, { filename = file, lnum = i, text = line })
          end
        end
        if #entries > 0 then
          vim.fn.setqflist(entries, "r")
          vim.cmd("copen")
        else
          vim.notify("No blame info", vim.log.levels.WARN)
        end
      end, "Blame each line in quickfix")
      --
      require("which-key").add({
        -- { "<leader>gh", mode = { "n", "v" }, group = "Actions" },
        { "<leader>gt", mode = { "n", "v" }, group = "Toggle actions" },
      })
      -- ]c - next hunk
      -- [c - prev hunk
    end,
  },
}
