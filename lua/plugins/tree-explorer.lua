-- Highlight todo, notes, etc in comments

return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = { on_attach = on_attach_change }

    -- open it by typing :NvimTreeToggle
    -- and then, you can type "a"
  }
}

-- vim: ts=2 sts=2 sw=2 et
