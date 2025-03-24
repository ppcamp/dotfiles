-- load default vim configs,
-- such as ignorecase; line numbers and or vim plugins

local function file_exists(file_path)
	local file = io.open(file_path, "r") -- Try to open the file in read mode
	if file then
		file:close() -- Close the file if it exists
		return true
	else
		return false
	end
end

if file_exists(vim.fn.expand("~/.vimrc")) then
	vim.cmd("source $HOME/.vimrc")
end

-- vim: ts=2 sts=2 sw=2 et
