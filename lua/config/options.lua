local is_wsl = require("utils.os").is_wsl

local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local extras = vim.o

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
extras.colorcolumn = "81"

-- Enable folding based on syntax
extras.foldmethod = "expr"
extras.foldexpr = "nvim_treesitter#foldexpr()"
-- Set the default fold level (higher levels are unfolded)
extras.foldlevel = 0
-- Enable folding by default (folding is turned on when the file is opened)
extras.foldenable = false

-- Fold methodology for bash filetypes
autocmd("FileType", {
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
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Show diagnostics in the command line when cursor moves
extras.updatetime = 500 -- delay time to 500ms
autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", border = "rounded" })
	end,
})

if is_wsl() then
	-- print("WSL")

	-- if set, it'll overwrite the internal clipboard to always use the system,
	-- which in windows, will add the carriage return char at the end of simple
	-- commands such as dd or p
	-- opt.clipboard = "unnamed" -- or unnamed plus
	opt.clipboard = ""
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = "powershell.exe -noprofile -command Get-Clipboard",
			["*"] = "powershell.exe -noprofile -command Get-Clipboard",
		},
		cache_enabled = 0,
	}
	-- else
	-- 	print("Not WSL")
end

-- vim: ts=2 sts=2 sw=2 et
