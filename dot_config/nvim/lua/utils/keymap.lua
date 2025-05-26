-- vim: ts=2 sts=2 sw=2 et

local M = {}

---Forward an keycombination event
---@param mode string Mode to forward the keycombination
---@param keycombination string Keycombination to forward
---@return string Forwarded keycombination
M.forward = function(mode, keycombination)
	return vim.api.nvim_replace_termcodes(vim.fn.maparg(keycombination, mode), true, true, true)
end

-- M.forwad_if_menuopen = function(mode, keycombination, activateFunction,)
-- 	vim.keymap.set(mode, keycombination, function()
-- 		if vim.fn.pumvisible() == 1 then
-- 			return "<C-n>" -- Navigate through the popup menu
-- 		else
--             return M.forward(mode, keycombination)
-- 		end
-- 	end, { expr = true, noremap = true, silent = true })
-- end

M.expr = function(mode, keycombination, expression)
	vim.keymap.set(mode, keycombination, expression, {
		expr = true,
		replace_keycodes = false,
	})
end

return M
