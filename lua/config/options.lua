local is_wsl = require("utils.os").is_wsl

local opt = vim.opt
local extras = vim.o

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- if you disabled this, then you'll need to check some icons
vim.g.have_nerd_font = true

opt.cursorline = true -- highlight current line

opt.number = true -- Set line numbering

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true -- Set to ignore case
opt.smartcase = true -- Ignore case only when there's no Uppercase char

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Set indentation options
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 4 -- Number of spaces that a tab counts for
opt.shiftwidth = 4 -- Number of spaces to use for indentation
opt.softtabstop = 4 -- Number of spaces for a tab key press

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

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

-- share unnamed (default, used by d/yank/etc) copy buffer with system
opt.clipboard = "unnamedplus"

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true

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
