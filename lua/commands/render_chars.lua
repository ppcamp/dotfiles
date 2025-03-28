local cmd = require("utils.command").command

-- Alternativaly, you can try to use od -c file.txt to see the characters
-- or cat -e file.txt or hexdump -C file.txt
cmd("RenderChars", function()
	vim.api.nvim_command("set listchars=tab:»\\ ,eol:¬,trail:•,extends:❯,precedes:❮,nbsp:+,space:·")
	vim.api.nvim_command("set list")

	vim.api.nvim_command("set ff?")
	-- :set fileformat=unix
end)

cmd("RenderCharsDisable", function()
	vim.api.nvim_command("set nolist")
end)
