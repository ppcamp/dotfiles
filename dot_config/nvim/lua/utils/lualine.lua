-- vim: ts=2 sts=2 sw=2 et

local M = {}

M.clock = function()
	return os.date(" %Y/%m/%d %H:%M")
end

M.workspace_diagnostic = function()
	local diagnostics = vim.diagnostic.get(nil)             -- nil means ALL buffers
	local counts = { error = 0, warn = 0, info = 0, hint = 0 }
	for _, d in ipairs(diagnostics) do
		if d.severity == vim.diagnostic.severity.ERROR then counts.error = counts.error + 1 end
		if d.severity == vim.diagnostic.severity.WARN then counts.warn = counts.warn + 1 end
		if d.severity == vim.diagnostic.severity.INFO then counts.info = counts.info + 1 end
		if d.severity == vim.diagnostic.severity.HINT then counts.hint = counts.hint + 1 end
	end
	return {
		error = counts.error,
		warn  = counts.warn,
		info  = counts.info,
		hint  = counts.hint,
	}
end
return M
