-- vim: ts=2 sts=2 sw=2 et

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
return {
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end,              desc = "Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end,              desc = "Previous Todo Comment" },
      { "<leader>ct", "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
      { "<leader>cT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "Todo/Fix/Fixme" },
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
}
