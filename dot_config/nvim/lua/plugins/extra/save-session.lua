return {
  "rmagatti/auto-session",
  lazy = false, -- Load this plugin immediately
  keys = {
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
  },
  opt = {
    auto_restore_enabled = true,
    auto_session_suppress_dirs = { "~/Downloads", "~/Documents", "~/Desktop/" },
  },
}
