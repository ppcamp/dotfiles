-- vim: ts=2 sts=2 sw=2 et

local M = {}

-- Define a global function that takes an argument
M.Greet = function(name)
	print("Hello, " .. name .. "!")
	-- vim.notify("Loaded script: " .. name, vim.log.levels.WARN)
	-- vim.notify("Loaded script: " .. name, vim.log.levels.INFO)
end

return M
