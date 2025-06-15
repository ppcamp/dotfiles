-- vim: ts=2 sts=2 sw=2 et

local cmd = require("utils.command").command

-- Add a line with the vim format to the end of the file
cmd("SaveNoAutoCmd", function()
  vim.api.nvim_command("noautocmd w")
end)
