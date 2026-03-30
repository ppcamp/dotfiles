-- vim: ts=2 sts=2 sw=2 et

-- Description: A nice and feature-rich notification system for Neovim
return {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline",                              -- use a classic cmdline view
      format = {
        cmdline = { icon = State.icons.ui.Command }, -- icon for the cmdline
        search_down = { icon = State.icons.ui.Search .. " " .. State.icons.ui.SearchDown },
        search_up = { icon = State.icons.ui.Search .. " " .. State.icons.ui.SearchUp },
      },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = false,      -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
  },
}
