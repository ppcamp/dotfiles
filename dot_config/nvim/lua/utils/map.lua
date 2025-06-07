-- vim: ts=2 sts=2 sw=2 et

local M = {}

--- Map a keybinding in Neovim.
---@param lhs string The keybinding to map
---@param rhs string|function The command or function to execute when the keybinding is pressing
---@param opts table|string|nil Optional table of options for the keybinding
---@param mode string|string[]|nil The mode(s) in which the keybinding should be active. Defaults to "n" (normal mode).
M.map = function(lhs, rhs, opts, mode)
  local inopts = {}

  if mode == nil then
    mode = "n" -- Default to normal mode
  end

  if type(opts) == "string" then
    inopts.desc = opts
    opts = {}
  elseif type(opts) == "nil" or type(opts) ~= "table" then
    error("opts must be a string or a table, got " .. type(opts))
  end

  inopts = vim.deepcopy(opts)

  return vim.keymap.set(mode, lhs, rhs, inopts)
end

return M
