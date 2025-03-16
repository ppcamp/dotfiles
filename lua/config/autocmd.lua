local cmd = vim.api.nvim_create_autocmd

-- Fix imports golang
cmd("BufWritePre", {
	pattern = "*.go",
	command = "silent !goimports -w %",
})

-- Fold methodology for bash filetypes
cmd("FileType", {
	pattern = "bash",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr =
			"getline(v:lnum) =~ '^\\s*\\(function\\|[a-zA-Z_][a-zA-Z0-9_]*\\)\\s*(.*)\\s*{$' ? '>' : '<'"
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
cmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Show diagnostics in the command line when cursor moves
cmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", border = "rounded" })
	end,
})

-- vim: ts=2 sts=2 sw=2 et
