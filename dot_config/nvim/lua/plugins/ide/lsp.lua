-- vim: ts=2 sts=2 sw=2 et

-- LSP Plugins
-- Language server protocol (used to generate editors errors, code navigation, etc)

---Alternative to map
---@param keys string
---@param func function | string
---@param desc string
---@param mode ? table | string
local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
end

--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
--
-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
local servers = {
  dotls = {},
  golangci_lint_ls = {},
  html = {},
  htmx = {},
  jsonls = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic", -- "off", "basic", "strict"
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace", -- "workspace" or "openFilesOnly"
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
        cargo = {
          allFeatures = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
  svelte = {
    filetypes = { "svelte", "html" }, -- svelte is a superset of html
    settings = {
      svelte = {
        plugin = {
          svelte = {
            completion = {
              autoImport = true,
            },
          },
        },
      },
    },
  },
  bashls = {},
  docker_compose_language_service = {},
  dockerls = {},
  gopls = {
    settings = {
      gopls = {
        -- directoryFilters = {
        --     "-",
        --     "+" .. cwd,
        -- },
        -- Exclude the 'pkg' directory from being indexed
        analyses = {
          unusedparams = true,
          unusedvariable = true,
          unreachable = true,
          modernize = true,
        },
        staticcheck = true,
        hints = {
          rangeVariableTypes = true,
          parameterNames = true,
          constantValues = true,
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          functionTypeParameters = true,
        },
      },
    },
  },
  intelephense = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  },
  sqls = {},
  markdown_oxide = {},
  marksman = {},
  -- 'systemd-language-server' = {},
}


-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer some lsp support methods only in specific files
---@return boolean
local function client_supports(client, method, bufnr)
  if vim.fn.has("nvim-0.11") == 1 then
    return client:supports_method(method, bufnr)
  else
    ---@diagnostic disable-next-line: param-type-mismatch
    return client.supports_method(method, { bufnr = bufnr })
  end
end

return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      local utils = require("utils.tables")
      local mason_lsp = utils.keys(servers) or {}

      require("mason-lspconfig").setup({
        ensure_installed = mason_lsp,
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- "j-hui/fidget.nvim",
      "lvimuser/lsp-inlayhints.nvim",
      "folke/which-key.nvim",
      "blink.cmp"
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Basic LSP setup for gopls
      local wk = require("which-key")
      local cmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      -- local capabilities = require("blink.cmp").get_lsp_capabilities()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local on_attach = function(client, bufnr) -- (client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      end

      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

        if not server.on_attach then
          server.on_attach = on_attach
        end

        lspconfig[server_name].setup(server)
        if not server.capabilities then
          server.capabilities = {}
        end

        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities)
      end

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = State.icons.lsp.Error,
            [vim.diagnostic.severity.WARN] = State.icons.lsp.Warning,
            [vim.diagnostic.severity.INFO] = State.icons.lsp.Info,
            [vim.diagnostic.severity.HINT] = State.icons.lsp.Hint,
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local msg = diagnostic.message

            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = msg,
              [vim.diagnostic.severity.WARN] = msg,
              [vim.diagnostic.severity.INFO] = msg,
              [vim.diagnostic.severity.HINT] = msg,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })



      -- LSP related keymaps
      cmd("LspAttach", {
        group = augroup("LspStartup", { clear = true }),
        callback = function(event)
          local icon = {
            name = vim.bo.filetype,
            cat = "filetype",
          }

          wk.add({
            { "<leader>l",  group = "LSP", icon = icon },
            { "<leader>nd", icon = icon },
            { "<leader>nr", icon = icon },
            { "<leader>ni", icon = icon },
            { "<leader>nt", icon = icon },
            { "<leader>sw", icon = icon },
            { "<leader>sW", icon = icon },
            { "<leader>sq", icon = icon },
            { "<leader>ca", icon = icon },
          })

          -- map("]g", function() vim.diagnostic.goto_next({ float = true }) end, "Goto next")
          -- map("[g", function() vim.diagnostic.goto_prev({ float = true }) end, "Goto previous")

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          map("<F12>", require("telescope.builtin").lsp_definitions, "Goto Definition")
          map("<leader>nd", require("telescope.builtin").lsp_definitions, "Goto Definition")

          -- Find references for the word under your cursor.
          map("<leader>nr", require("telescope.builtin").lsp_references, "Goto References")
          map("<S-F12>", require("telescope.builtin").lsp_references, "Goto References")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("<leader>ni", require("telescope.builtin").lsp_implementations, "Goto Implementation")
          map("<C-F12>", require("telescope.builtin").lsp_implementations, "Goto Implementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("<leader>nt", require("telescope.builtin").lsp_type_definitions, "Type Definition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>sw", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("<leader>sW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

          -- Diagnostics
          map("<leader>sq", require("telescope.builtin").diagnostics, "Diagnostics")

          -- Diagnostic keymaps
          map("<leader>cq", vim.diagnostic.setloclist, "Quickfix panel")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<F2>", vim.lsp.buf.rename, "Rename", { "n", "i" })

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("<C-.>", vim.lsp.buf.code_action, "Code Action", { "i" })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("<leader>nD", vim.lsp.buf.declaration, "Goto Declaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client_supports(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.lsp.inlay_hint.enable(true)

            require("lsp-inlayhints").on_attach(client, event.buf)

            map("<leader>ch", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end

          if client and client_supports(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = augroup("kickstart-lsp-highlight", { clear = false })

            cmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            cmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            cmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })
    end,
  }
}
