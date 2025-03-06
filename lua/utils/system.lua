-- Usefull system related functions

local M = {}

M.is_wsl = function()
	-- execute and get buffer
	local f = io.popen("echo $WSL_DISTRO_NAME")

	if f then
		-- read all buffer
		local output = f:read("*a")
		f:close()

		return not output == "" -- if variable is not empty
	end

	return false
end

return M

-- vim: ts=2 sts=2 sw=2 et
