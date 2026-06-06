-- vim: ts=2 sts=2 sw=2 et

local cmd = require("utils.command").command

-- Load only if opens a go filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  once = true,
  callback = function()
    -- Print the GOROOT environment variable
    cmd("GoRoot", function()
      local out = vim.system({ "go", "env", "GOROOT" }, { text = true }):wait().stdout or ""
      local root = out:gsub("%s+$", "")
      print(root)
    end)
  end,
})
