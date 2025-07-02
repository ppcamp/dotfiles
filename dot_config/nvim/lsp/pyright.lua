-- vim: ts=2 sts=2 sw=2 et

-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- Options: off, basic, strict
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace", -- Options: workspace, openFilesOnly
      },
      formatting = {
        provider = "black", -- Options: autopep8, black, yapf
      },
    },
  },
}
