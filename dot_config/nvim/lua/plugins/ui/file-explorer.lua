-- vim: ts=2 sts=2 sw=2 et

-- Show a explorer view, with folders, and file icons
return {
  "stevearc/oil.nvim",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
  config = function()
    require("oil").setup({
      default_file_explorer = true, -- start up nvim with oil instead of netrw
      columns = {},
      keymaps = {
        ["<C-h>"] = false,
        ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
      },
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    })

    require("which-key").add({
      {
        "<leader>-",
        icon = { icon = State.icons.ui.Folder, color = "green" },
        mode = { "n" }
      },
      {
        "<leader>+",
        icon = { icon = State.icons.ui.Folder, color = "green" },
        mode = { "n" }
      },
    })

    vim.keymap.set("n", "<leader>+", "<CMD>Oil .<CR>", { desc = "Explorer (workspace)" })
    vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Explorer (cwd)" })

    -- open parent dir in float window
    -- vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil", -- Adjust if Oil uses a specific file type identifier
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,

}
