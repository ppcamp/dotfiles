-- Set to true if you have a Nerd Font installed and selected in the terminal
-- if you disabled this, then you'll need to check some icons
vim.g.have_nerd_font = true

vim.opt.number = true -- Set line numbering
vim.opt.ignorecase = true -- Ignore case when searching

-- Set indentation options
vim.opt.shiftwidth = 4   -- Number of spaces for each indentation level
vim.opt.tabstop = 4      -- Number of spaces a tab character represents
vim.opt.expandtab = true -- Use spaces instead of tabs


-- Use ripgrep (rg) for :grep
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
-- Set the format for parsing grep output
vim.opt.grepformat = "%f:%l:%c:%m"
