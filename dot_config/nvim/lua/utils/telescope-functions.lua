-- vim: ts=2 sts=2 sw=2 et

local M = {}

M.find_files = function()
  local builtin = require("telescope.builtin")
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

M.find_golang_text_files = function()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    prompt_title = "Search words in GOROOT/src",
    cwd = vim.api.nvim_exec("GoRoot", true) .. "/src",
  })
end

M.find_golang_files = function()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    prompt_title = "Search files in GOROOT/src",
    cwd = vim.api.nvim_exec("GoRoot", true),
  })
end

M.find_man_pages = function()
  local builtin = require("telescope.builtin")
  builtin.man_pages({ sections = { "ALL" } })
end

--- Opens Telescope to search git commits for the current buffer, following file history.
--- Uses 'git log --follow --full-history' to include renames and full commit history.
--- Presents results in a Telescope picker with multi-select enabled.
M.find_commits = function()
  local builtin = require("telescope.builtin")
  builtin.git_bcommits({
    git_command = { "git", "log", "--follow", "--full-history", "--pretty=oneline", "--abbrev-commit" },
    prompt_title = "Search Commits in current buffer (follow enabled)",
    multi_select = true,
  })
end

--- Opens a Telescope picker to search git commits affecting the visually selected line range.
--- Uses 'git log -L' to show commits for the selected range in the current buffer.
--- Results are displayed in a Telescope picker with multi-select enabled.
M.find_commits_range = function()
  local builtin = require("telescope.builtin")
  -- Get the start and end positions of the visual selection
  local _, start_line, _, _ = unpack(vim.fn.getpos("v"))
  local _, end_line, _, _ = unpack(vim.fn.getpos("."))

  builtin.git_bcommits_range({
    git_command = { "git", "log", "--pretty=oneline", "--full-history", "--abbrev-commit", "--no-patch", "-L" },
    prompt_title = "Search Commits in current range",
    multi_select = true,
    from = start_line,
    to = end_line,
  })
end

return M
