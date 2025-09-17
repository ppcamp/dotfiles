-- vim: ts=2 sts=2 sw=2 et

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Override golangci-lint to use JSON output
      lint.linters.golangcilint = vim.tbl_extend("force", lint.linters.golangcilint, {
        args = {
          "run",
          "--output.json.path",
          "stdout",
          "--issues-exit-code=1",
          "--show-stats=false", -- disable "0 issues"
        },
        append_fname = true,
      })

      -- Enable only golangci-lint for Go
      lint.linters_by_ft = {
        go = { "golangcilint" },
      }

      -- Auto lint on save
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Manual trigger
      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
