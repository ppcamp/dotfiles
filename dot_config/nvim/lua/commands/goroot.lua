-- vim: ts=2 sts=2 sw=2 et

local cmd = require("utils.command").command

-- Print the GOROOT environment variable
cmd("GoRoot", function()
  local root = vim.fn.system('go env GOROOT'):gsub('%s+$', '')
  print(root)
end)
