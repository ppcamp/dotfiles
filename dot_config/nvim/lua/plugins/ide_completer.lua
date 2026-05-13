-- vim: ts=2 sts=2 sw=2 et

return { -- Autocompletion support.
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "supermaven-inc/supermaven-nvim",
      opts = {
        disable_inline_completion = true, -- force supermaven to use cmp
        disable_keymaps = true, -- prevent supermaven from overriding cmp keymaps
      },
    },
    "Huijiro/blink-cmp-supermaven",
  },
  version = "1.*", -- use a release tag to download pre-built binaries
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "default",
      ["<Tab>"] = {
        "select_and_accept",
        "fallback",
      },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      keyword = { range = "full" },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      ghost_text = {
        enabled = true,
      },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
    sources = {
      default = { "supermaven", "lsp", "snippets", "path" },
      providers = {
        supermaven = {
          name = "supermaven",
          module = "blink-cmp-supermaven",
          async = true,
          score_offset = 100,
        },
      },
    },
    cmdline = {
      -- Default list of enabled providers for cmdline
      -- You can override this in your cmdline config
      -- default = { "path", "buffer" },
      enabled = false, -- doc unclear, but when enabled, freezes when using terminal commands
    },
    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
