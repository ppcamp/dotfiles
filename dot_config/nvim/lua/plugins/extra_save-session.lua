return {
  "rmagatti/auto-session",
  lazy = false, -- Load this plugin immediately
  keys = {
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
  },
  opt = {
    auto_restore_enabled = true,
    auto_session_suppress_dirs = { "~/Downloads" },
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
