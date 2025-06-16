-- vim: ts=2 sts=2 sw=2 et


local function next_quickfix()
  if require("trouble").is_open() then
    require("trouble").next({ skip_groups = true, jump = true })
  else
    local ok, err = pcall(vim.cmd.cnext)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end

local function prev_quickfix()
  if require("trouble").is_open() then
    require("trouble").prev({ skip_groups = true, jump = true })
  else
    local ok, err = pcall(vim.cmd.cprev)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end

-- better diagnostics list and others
return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  keys = {
    { "<leader>cx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
    { "<leader>cX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
    { "<leader>cS", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP references/definitions/... (Trouble)" },
    { "<leader>cl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
    { "<leader>cq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
    { "[q",         prev_quickfix,                                      desc = "Previous Trouble/Quickfix Item" },
    { "]q",         next_quickfix,                                      desc = "Next Trouble/Quickfix Item" },
  },
}
