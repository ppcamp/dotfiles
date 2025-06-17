-- vim: ts=2 sts=2 sw=2 et

-- Autocompletion support.
--
-- With this, we'll be able to generate and accept suggestions from LSP

return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets" },
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
    completion = { documentation = { auto_show = true } },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
      -- Default list of enabled providers for cmdline
      -- You can override this in your cmdline config
      -- default = { "path", "buffer" },
      enabled = false, -- doc unclear, but when enabled, freezes when using terminal commands
      completion = {
        menu = {
          -- guarantee to not bug it with huge amount of system completions
          auto_show = false,
        },
      },
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
