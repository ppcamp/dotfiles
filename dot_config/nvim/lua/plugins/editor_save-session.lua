return {
  "rmagatti/auto-session",
  lazy = false, -- Load this plugin immediately
  keys = {
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
  },
  opts = {
    auto_restore = false,
    suppressed_dirs = { "~/Downloads", "~", "~/Desktop/", "~/Área de Trabalho" },
    root_dir = vim.fn.stdpath("data") .. "/sessions/",
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
