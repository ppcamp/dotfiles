-- vim: ts=2 sts=2 sw=2 et

-- Way more features, such as interface generation, debugging, etc,
return {
  "fatih/vim-go",
  -- do not load if spawned in subshell by kitty (without load user ENV)
  -- Loading it only if opens a go file
  ft = { "go", "gomod", "gosum", "gotmpl" },
  config = function()
    vim.g.go_gopls_enabled = 1 -- en/disable vim-go's gopls integration

    vim.g.go_gopls_options = { "-remote=auto" } -- use vim.lsp for gopls

    -- vim.cmd("GoInstallBinaries")
    local out = vim.system({ "go", "env", "GOBIN" }, { text = true }):wait().stdout or ""
    local gobin = out:gsub("%s+$", "")

    vim.g.go_bin_path = gobin

    vim.api.nvim_create_user_command("GoInstallAndReshim", function()
      vim.cmd("GoInstallBinaries")
      vim.system({ "asdf", "reshim", "golang" }, { text = true }, function(_)
        print("Installed binaries and reshimmmed golang with asdf")
      end)
    end, {})
  end,
}
