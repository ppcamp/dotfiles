local is_wsl = require("utils.system").is_wsl

local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- if you disabled this, then you'll need to check some icons
vim.g.have_nerd_font = true

opt.cursorline = true -- highlight current line

opt.number = true -- Set line numbering
opt.ignorecase = true -- Ignore case when searching

-- Set indentation options
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 4 -- Number of spaces that a tab counts for
opt.shiftwidth = 4 -- Number of spaces to use for indentation
opt.softtabstop = 4 -- Number of spaces for a tab key press

-- Use ripgrep (rg) for :grep
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
-- Set the format for parsing grep output
opt.grepformat = "%f:%l:%c:%m"

-- Numbering basing on the current cursor position (usefull to apply motions)
opt.relativenumber = true

-- Show a reference line at position 80
vim.o.colorcolumn = "81"

-- Enable folding based on syntax
vim.o.foldmethod = "indent"
-- Set the default fold level (higher levels are unfolded)
vim.o.foldlevel = 0
-- Enable folding by default (folding is turned on when the file is opened)
vim.o.foldenable = false

autocmd("FileType", {
	pattern = "bash",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr =
			"getline(v:lnum) =~ '^\\s*\\(function\\|[a-zA-Z_][a-zA-Z0-9_]*\\)\\s*(.*)\\s*{$' ? '>' : '<'"
	end,
})

-- Show diagnostics in the command line when cursor moves
vim.o.updatetime = 500 -- delay time to 500ms
autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", border = "rounded" })
	end,
})

-- Configs applied to windows only
if is_wsl() then
	-- print("windows")

	-- CONFIGS FOR WSL (windows only)
	vim.opt.clipboard = "unnamedplus"
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = "powershell.exe Get-Clipboard",
			["*"] = "powershell.exe Get-Clipboard",
		},
		cache_enabled = 0,
	}
	-- else
	-- 	 print("not windows")
end

-- vim: ts=2 sts=2 sw=2 et
