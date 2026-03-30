-- vim: ts=2 sts=2 sw=2 et

local M = {}

---Forward an keycombination event
---@param mode string Mode to forward the keycombination
---@param keycombination string Keycombination to forward
---@return string Forwarded keycombination
M.forward = function(mode, keycombination)
  return vim.api.nvim_replace_termcodes(vim.fn.maparg(keycombination, mode), true, true, true)
end
-- M.forwad_if_menuopen = function(mode, keycombination, activateFunction,)
-- 	vim.keymap.set(mode, keycombination, function()
-- 		if vim.fn.pumvisible() == 1 then
-- 			return "<C-n>" -- Navigate through the popup menu
-- 		else
--             return M.forward(mode, keycombination)
-- 		end
-- 	end, { expr = true, noremap = true, silent = true })
-- end
M.expr = function(mode, keycombination, expression)
  vim.keymap.set(mode, keycombination, expression, {
    expr = true,
    replace_keycodes = false,
  })
end

---@class Icons
---@field icon string|nil Optional icon to display in the keybinding description
---@field icon_color string|nil Optional icon color

---@class Opts : vim.keymap.set.Opts,Icons

--- Map a keybinding in Neovim.
---@param lhs string The keybinding to map
---@param rhs string|function The command or function to execute when the keybinding is pressing
---@param opts Opts|string|nil Optional table of options for the keybinding
---@param mode string|string[]|nil The mode(s) in which the keybinding should be active. Defaults to "n" (normal mode).
M.map = function(lhs, rhs, opts, mode)
  local o = {}

  if mode == nil then
    mode = "n" -- Default to normal mode
  end

  if type(opts) == "string" then
    o.desc = opts
  elseif type(opts) == "nil" or type(opts) ~= "table" then
    error("opts must be a string or a table, got " .. type(opts))
  else
    o = vim.deepcopy(opts)
  end

  local icon = nil -- default icon
  if o.icon then
    icon = o.icon
    o.icon = nil -- Remove icon from options to avoid conflicts
  end

  require("which-key").add({
    lhs,
    icon = { icon = icon, color = o.icon_color or "blue" },
    desc = o.desc or "No description provided",
    mode = mode
  })

  return vim.keymap.set(mode, lhs, rhs, o)
end

--- Map a keybinding in Neovim.
--- FIXME: doesnt work
---@param lhs string The keybinding to map
---@param opts Icons table of options for the keybinding
---@param mode string|string[]|nil The mode(s) in which the keybinding should be active. Defaults to "n" (normal mode).
M.wk = function(lhs, opts, mode)
  if mode == nil then
    mode = "n" -- Default to normal mode
  end

  local icon = nil -- default icon
  if opts.icon then
    icon = opts.icon
  end

  require("which-key").add({
    lhs,
    icon = { icon = icon, color = opts.icon_color or "blue" },
    desc = opts.desc or "No description provided",
    mode = mode
  })

  return vim.keymap.set(mode, lhs, rhs, o)
end


return M
