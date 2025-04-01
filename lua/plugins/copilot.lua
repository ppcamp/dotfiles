-- Copilot AI configuration for Neovim
--
-- To setup local, run :Copilot setup
--
-- See `:help copilot` for more information.

-- <ctrl+]> Dismiss the current suggestion. <Plug>(copilot-dismiss)
-- <alt+]> Cycle to the next suggestion, if one is available. <Plug>(copilot-next)
-- <alt+[> Cycle to the previous suggestion. <Plug>(copilot-previous)
-- <alt+\> Explicitly request a suggestion, even if Copilot <Plug>(copilot-suggest) is disabled.
-- <alt+Right> Accept the next word of the current suggestion. <Plug>(copilot-accept-word)
-- <ctrl+alt+Right> Accept the next line of the current suggestion. <Plug>(copilot-accept-line)

return {
  "github/copilot.vim",
  enabled = true,
  priority = 200,
  config = function()
    local map = function(lhs, rhs, mode, opts)
      opts = opts or {}
      mode = mode or "i"
      opts.silent = true
      opts.noremap = true
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("<C-]>", "<Plug>(copilot-dismiss)")
  end,
}

-- vim: ts=2 sts=2 sw=2 et
