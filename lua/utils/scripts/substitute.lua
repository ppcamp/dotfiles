-- vim: ts=2 sts=2 sw=2 et
--
-- All extra commands that I think usefull

local M = {}

---Define a function to substitute with the contents of a register
---@example vim.api.nvim_set_keymap('n', '<leader>sr', ':lua substitute_with_register("foo", "+")<CR>', { noremap = true, silent = true })
---@param pattern string The pattern to substitute
---@param reg string The register to use as the replacement
M.SubstituteWithRegister = function(pattern, reg)
	-- Fetch the contents of the specified register
	local replacement = vim.fn.getreg(reg)

	-- Perform the substitution with the pattern and register content
	vim.api.nvim_command(string.format("%%s/%s/\\=%s/g", pattern, vim.fn.escape(replacement, "/")))
end

return M
