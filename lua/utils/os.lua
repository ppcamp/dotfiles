-- vim: ts=2 sts=2 sw=2 et

-- Usefull system related functions

local trim = require("utils.strings").trim

local M = {}

---Check if current terminal is running inside a WSL
---@return boolean True if windows
M.is_wsl = function()
	-- execute and get buffer
	local f = io.popen("echo $WSL_DISTRO_NAME")

	if f then
		-- read all buffer
		local output = f:read("*a")
		f:close()

		output = trim(output)
		return output and output ~= "" -- if variable is not empty
	end

	return false
end

return M
