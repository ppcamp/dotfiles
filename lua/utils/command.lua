-- vim: ts=2 sts=2 sw=2 et

local M = {}

---Create a vim binding/command to a function.
---@param command string The command shortcut name.
---@param cb function The callback to be executed
---@param opts ? vim.api.keyset.user_command Args to pass to callback
M.command = function(command, cb, opts)
	local keyset = opts or {}
	vim.api.nvim_create_user_command(command, cb, keyset)
end

return M
