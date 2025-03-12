-- All extra commands that I think usefull
--
-- Scripts that aren't defined using cmd, will require the `:lua` prefix
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

---Define a function to substitute with the contents of a register
---@example vim.api.nvim_set_keymap('n', '<leader>sr', ':lua substitute_with_register("foo", "+")<CR>', { noremap = true, silent = true })
---@param pattern string The pattern to substitute
---@param reg string The register to use as the replacement
function SubstituteWithRegister(pattern, reg)
	-- Fetch the contents of the specified register
	local replacement = vim.fn.getreg(reg)

	-- Perform the substitution with the pattern and register content
	vim.api.nvim_command(string.format("%%s/%s/\\=%s/g", pattern, vim.fn.escape(replacement, "/")))
end

-- vim: ts=2 sts=2 sw=2 et
