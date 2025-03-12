-- All extra commands that I think usefull

local cmd = require("utils.command").command
local api = vim.api

-- Add a line with the vim format to the end of the file
cmd("AddVimFormatLine", function()
	local line_count = api.nvim_buf_line_count(0)
	local text = "vim: ts=2 sts=2 sw=2 et"
	api.nvim_buf_set_lines(0, line_count, line_count, false, { text })
	api.nvim_win_set_cursor(0, { line_count + 1, 0 })
end)

---Just print a Test message
---@example :lua Teste()
function Test()
	print("Test")
end

-- vim: ts=2 sts=2 sw=2 et
