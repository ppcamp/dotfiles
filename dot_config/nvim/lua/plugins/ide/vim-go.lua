-- vim: ts=2 sts=2 sw=2 et

-- Way more features, such as interface generation, debugging, etc,
return {
  "fatih/vim-go",
  config = function()
    vim.g.go_gopls_enabled = 0 -- disable vim-go's gopls integration

    -- vim.cmd("GoInstallBinaries")
  end,
}
