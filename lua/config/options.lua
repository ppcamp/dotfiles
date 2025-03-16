local is_wsl = require("utils.os").is_wsl

local opt = vim.opt
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

-- Show diagnostics in the command line when cursor moves
extras.updatetime = 500 -- delay time to 500ms

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
