-- vim: ts=2 sts=2 sw=2 et

-- search/replace in multiple files
return {
  -- {
  --   -- A search panel and replacer for multi files
  --   -- https://github.com/nvim-pack/nvim-spectre
  --   "nvim-pack/nvim-spectre",
  -- },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>r",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
