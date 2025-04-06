-- vim: ts=2 sts=2 sw=2 et

local M = {}

---Remove empty lines and spaces
---@param buf string Word to trim
---@return string Trimmed word
M.trim = function(buf)
	local trimmed = buf:gsub("^[ \t\n]*", "") -- ignore other returns
	return trimmed
end

return M
