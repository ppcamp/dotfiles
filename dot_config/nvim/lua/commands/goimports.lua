-- vim: ts=2 sts=2 sw=2 et

local cmd = vim.api.nvim_create_autocmd

-- Fix imports golang
cmd("BufWritePre", {
	pattern = "*.go",
	command = "silent !goimports -w %",
})
