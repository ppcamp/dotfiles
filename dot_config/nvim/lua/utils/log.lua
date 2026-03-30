-- vim: ts=2 sts=2 sw=2 et

local M = {}

---@type Level
local level = 2

-- local notify = require("mini.notify").notify
local notify = vim.notify

---@enum Level
M.levels = {
	TRACE = 0,
	DEBUG = 1,
	INFO = 2,
	WARN = 3,
	ERROR = 4,
	OFF = 5,
}

---@param msg string Message
---@param lvl Level level to log
M.log = function(msg, lvl)
	if lvl < level then
		return
	end

	return notify(msg, lvl)
end

---Info function
---@param msg string
M.info = function(msg)
	M.log(msg, M.levels.INFO)
end

---Info function
---@param msg string
M.debug = function(msg)
	M.log(msg, M.levels.DEBUG)
end

---@param lvl Level
M.set_level = function(lvl)
	level = lvl
end

return M
