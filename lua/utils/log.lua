local M = {}

---Info function
---@param msg string
M.info = function(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

---Info function
---@param msg string
M.debug = function(msg)
	vim.notify(msg, vim.log.levels.DEBUG)
end

M.levels = vim.log.levels
M.log = vim.notify

return M

-- vim: ts=2 sts=2 sw=2 et
