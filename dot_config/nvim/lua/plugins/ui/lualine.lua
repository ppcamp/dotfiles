-- vim: ts=2 sts=2 sw=2 et

-- Line bar showing extra informations

return {
  {
    -- https://www.nerdfonts.com/cheat-sheet
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
      },
    },
    config = function()
      local function clock()
        return os.date(" %Y/%m/%d %H:%M")
      end

      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "", -- { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
            },
            "nvim-dap-ui",
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              -- path = 4, -- filename and path (0:filename, 1:relative path)
              path = 0,
              symbols = { modified = " ", readonly = " " },
            },
            "%=", -- center text section
            {
              "navic",
              color_correction = "static",
              navic_opts = {
                highlight = true,
                depth_limit = 3,
                separator = "  ",
                click = true,
              },
              bg = "#ffffff"
            },
          },
          lualine_x = {
            "nvim-dap-ui",
          },
          lualine_y = {
            -- "progress",
            -- "diagnostics",
            "quickfix",
            {
              'diagnostics',
              -- use a custom source: all workspace buffers
              sources = { function()
                local diagnostics = vim.diagnostic.get(nil) -- nil means ALL buffers
                local counts = { error = 0, warn = 0, info = 0, hint = 0 }
                for _, d in ipairs(diagnostics) do
                  if d.severity == vim.diagnostic.severity.ERROR then counts.error = counts.error + 1 end
                  if d.severity == vim.diagnostic.severity.WARN then counts.warn = counts.warn + 1 end
                  if d.severity == vim.diagnostic.severity.INFO then counts.info = counts.info + 1 end
                  if d.severity == vim.diagnostic.severity.HINT then counts.hint = counts.hint + 1 end
                end
                return {
                  error = counts.error,
                  warn  = counts.warn,
                  info  = counts.info,
                  hint  = counts.hint,
                }
              end },
              symbols = {
                error = State.icons.lsp.Error .. ':',
                warn = State.icons.lsp.Warning .. ':',
                info = State.icons.lsp.Info .. ':',
                hint = State.icons.lsp.Hint .. ':'
              },
              colored = true,
              update_in_insert = false,
            },
          },
          lualine_z = {
            "location",
            "filetype",
            "fileformat",
            { "encoding", separator = { right = "" }, left_padding = 2 },
            -- { clock, separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {
          "lazy",
          "man",
          "mason",
          "nvim-dap-ui",
          "nvim-tree",
          "quickfix",
          "symbols-outline",
        },
      })
    end,
  },
}
