-- vim: ts=2 sts=2 sw=2 et

-- Scripts that aren't defined using cmd, will require the `:lua` prefix
local cmd = require("utils.command").command
local api = vim.api

-- Add a line with the vim format to the end of the file
cmd("AddVimFormatLine", function()
  local replacement = {
    -- tabstop (ts)       - number of spaces that a <Tab> counts for
    -- softtabstop (sts)  - number of spaces that a <Tab> counts for while editing
    -- shiftwidth (sw)    - number of spaces to use for each step of (auto)indent
    -- expandtab (et)     - use spaces instead of tabs
    -- noexpandtab (noet) - use tabs instead of spaces
    "vim: ts=2 sts=2 sw=2 et",
    "",
  }
  -- local lines = api.nvim_buf_line_count(buf)
  local begin_ = 0 -- lines
  local exclude = 0 -- do not replace any lines

  local buf = api.nvim_get_current_buf()
  local window = api.nvim_get_current_win()

  -- api.nvim_buf_set_lines(buf, lines, lines, false, { text })
  -- api.nvim_win_set_cursor(buf, { lines + 1, 0 })
  api.nvim_buf_set_lines(buf, begin_, exclude, false, replacement)
  api.nvim_win_set_cursor(window, { 1, 0 })
end)
