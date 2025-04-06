-- vim: ts=2 sts=2 sw=2 et

local cmd = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup("shell_autocmd", { clear = true })

-- Fold methodology for bash filetypes
cmd("FileType", {
	desc = "Set foldmethod for bash files",
	group = group,
	pattern = "bash",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr =
			"getline(v:lnum) =~ '^\\s*\\(function\\|[a-zA-Z_][a-zA-Z0-9_]*\\)\\s*(.*)\\s*{$' ? '>' : '<'"
	end,
})

-- Fold methodology for bash filetypes
cmd("BufWritePre", { -- Before writing to the file, run this
	pattern = "*.sh,*.bashrc,*.zsh,.zshrc",
	group = group,

	-- WARN: if using this, needs to reload from buffer-
	-- command = "silent !shfmt -i 2 -ci -w %",

	-- Read the output of shfmt and replace the current buffer with it
	command = "%!shfmt -i 2 -ci",
})
