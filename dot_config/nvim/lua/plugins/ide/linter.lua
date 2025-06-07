-- vim: ts=2 sts=2 sw=2 et

return {

  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
      local lint = require("lint")
      -- lint.linters_by_ft = lint.linters_by_ft or {}

      -- if we don't specify to not use linters, it'll throw error everytime
      -- lint.linters_by_ft = {}

      -- lint.linters_by_ft["markdown"] = { "markdownlint" } -- NOTE: it requires markdown/nodejs
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- lint.try_lint(nil, { ignore_errors = nil })
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
