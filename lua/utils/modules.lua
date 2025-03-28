-- vim: set et ts=2 sts=2 sw=2
local M = {}

local debug = require("utils.log").debug

---Load all lua files inside folder.
---@param folder string Folder to load all files inside of it
M.load_folder = function(folder)
	local config_path = vim.fn.stdpath("config") .. "/lua/" .. folder
	for _, file in ipairs(vim.fn.globpath(config_path, "*.lua", false, true)) do
		debug("Loading: " .. file)
		dofile(file)
	end
end

return M
