-- vim: ts=2 sts=2 sw=2 et

-- Copilot AI configuration for Neovim
return {
  recommended = true,
  { -- copilot
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  { -- copilot cmp source
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            -- kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },

  -- lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     table.insert(
  --       opts.sections.lualine_x,
  --       2,
  --       LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
  --         local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
  --         if #clients > 0 then
  --           local status = require("copilot.api").status.data.status
  --           return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
  --         end
  --       end)
  --     )
  --   end,
  -- },

}

-- To setup local, run :Copilot setup
--
-- See `:help copilot` for more information.

-- <ctrl+]> Dismiss the current suggestion. <Plug>(copilot-dismiss)
-- <alt+]> Cycle to the next suggestion, if one is available. <Plug>(copilot-next)
-- <alt+[> Cycle to the previous suggestion. <Plug>(copilot-previous)
-- <alt+\> Explicitly request a suggestion, even if Copilot <Plug>(copilot-suggest) is disabled.
-- <alt+Right> Accept the next word of the current suggestion. <Plug>(copilot-accept-word)
-- <ctrl+alt+Right> Accept the next line of the current suggestion. <Plug>(copilot-accept-line)

-- return {
-- 	"github/copilot.vim",
-- 	enabled = true,
-- 	priority = 200,
-- 	config = function()
-- 		local map = function(lhs, rhs, mode, opts)
-- 			opts = opts or {}
-- 			mode = mode or "i"
-- 			opts.silent = true
-- 			opts.noremap = true
-- 			vim.keymap.set(mode, lhs, rhs, opts)
-- 		end

-- 		map("<C-]>", "<Plug>(copilot-dismiss)")
-- 	end,
-- }
