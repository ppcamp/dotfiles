local opt = vim.opt

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- if you disabled this, then you'll need to check some icons
vim.g.have_nerd_font = true

opt.cursorline = true -- highlight current line

opt.number = true -- Set line numbering
opt.ignorecase = true -- Ignore case when searching

-- Set indentation options
opt.shiftwidth = 4 -- Number of spaces for each indentation level
opt.tabstop = 4 -- Number of spaces a tab character represents
opt.expandtab = true -- Use spaces instead of tabs

-- Use ripgrep (rg) for :grep
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
-- Set the format for parsing grep output
opt.grepformat = "%f:%l:%c:%m"

opt.relativenumber = true

-- vim: ts=2 sts=2 sw=2 et
