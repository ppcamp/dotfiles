-- vim: ts=2 sts=2 sw=2 et

return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  opts = function()
    local ai = require("mini.ai")
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
        d = { "%f[%d]%d+" },                                                          -- digits
        e = {                                                                         -- Word with case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        u = ai.gen_spec.function_call(),                           -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    }
  end,

  config = function(_, opts)
    -- Better Around/Inside textobjects
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    --  - ci`  - [C]hange [I]nside [`]backtick
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
    require("mini.ai").setup(opts)

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
    --
    -- This plugin also enable ci`, di`, ca`, da` and so on
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- add            = 'sa', to Add surrounding in Normal and Visual modes
    -- delete         = 'sd', to Delete surrounding
    -- find           = 'sf', to Find surrounding (to the right)
    -- find_left      = 'sF', to Find surrounding (to the left)
    -- highlight      = 'sh', to Highlight surrounding
    -- replace        = 'sr', to Replace surrounding
    -- update_n_lines = 'sn', to Update `n_lines`
    -- suffix_last    = 'l',  to Suffix to search with "prev" method
    -- suffix_next    = 'n',  to Suffix to search with "next" method
    --
    -- sai(" to add surrounding in everything inside the parentheses
    require("mini.surround").setup()

    -- Add/Remove indentation
    -- gas to -> align text like below
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
    --
    -- Press s                to enter split Lua pattern.
    -- Press j                to choose justification side from available ones ("left", "center", "right", "none").
    -- Press m                to enter merge delimiter.
    -- Press f                to enter filter Lua expression               to configure which parts will be affected (like "align only first column").
    -- Press i                to ignore some commonly unwanted split matches.
    -- Press p                to pair neighboring parts so they be aligned together.
    -- Press t                to trim whitespace from parts.
    -- Press <BS> (backspace) to delete some last pre-step.
    require("mini.align").setup()

    -- Move using alt+hjkl keys
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
    --
    require("mini.move").setup()

    -- Add animations to scroll, window resizing, and other actions
    -- require("mini.animate").setup()

    -- Add notification plugin popup
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-notify.md
    -- require("mini.notify").setup({})
  end,
}
