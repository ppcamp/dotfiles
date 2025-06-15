-- vim: ts=2 sts=2 sw=2 et

-- Show a explorer view, with folders, and file icons

return {
  "stevearc/oil.nvim",
  -- enabled = false,
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
      { "<leader>-", desc = "File explorer (cwd)", icon = State.icons.ui.Folder, mode = { "n" } },
      { "-",         desc = "File mode",           icon = State.icons.ui.Folder, mode = { "n" } },
    })

    -- opens parent dir over current active window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    -- open parent dir in float window
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil", -- Adjust if Oil uses a specific file type identifier
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,

}




--- Define your custom on_attach_change function
--- @param bufnr integer
-- local on_attach_change = function(bufnr)
-- 	-- Here, you can define any actions you want to take when nvim-tree is opened
-- 	-- For example, you can bind specific keys or trigger other events
--
-- 	-- Example: Setting some keybindings for the NvimTree buffer
-- 	local opts = { noremap = true, silent = true }
--
-- 	-- Add custom key mappings for the nvim-tree buffer
-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "a", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree when 'a' is pressed
-- -- end
-- local function on_attach(bufnr)
-- 	local api = require("nvim-tree.api")
-- 	local map = vim.keymap.set

-- 	local function opts(desc)
-- 		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- 	end

-- 	-- default mappings
-- 	api.config.mappings.default_on_attach(bufnr)

-- 	-- custom mappings
-- 	map("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
-- 	map("n", "?", api.tree.toggle_help, opts("Help"))
-- end

-- return {
-- 	{
-- 		"nvim-tree/nvim-tree.lua",
-- 		opts = { on_attach = on_attach, ignore = false },
-- 		-- open it by typing :NvimTreeToggle
-- 		-- and then, you can type "a"

-- 		config = function()
-- 			local map = vim.keymap.set

-- 			map("n", "<leader><leader>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })

-- 			require("nvim-tree").setup({
-- 				view = {
-- 					float = {
-- 						enable = true,
-- 						open_win_config = function()
-- 							local columns = vim.o.columns
-- 							local lines = vim.o.lines

-- 							local width = math.floor(columns * 0.5)
-- 							local height = math.floor(lines * 0.6)

-- 							return {
-- 								relative = "editor",
-- 								border = "rounded",
-- 								width = width,
-- 								height = height,
-- 								row = math.floor((lines - height) / 2),
-- 								col = math.floor((columns - width) / 2),
-- 							}
-- 						end,
-- 					},
-- 					-- Disable default fixed position
-- 					adaptive_size = false,
-- 					side = "left",
-- 					width = 30,
-- 				},
-- 			})
-- 		end,
-- 	},
-- }


-- -- vim: ts=2 sts=2 sw=2 et

-- -- Show a explorer view, with folders, and file icons
-- --
-- --- Define your custom on_attach_change function
-- --- @param bufnr integer
-- -- local on_attach_change = function(bufnr)
-- -- 	-- Here, you can define any actions you want to take when nvim-tree is opened
-- -- 	-- For example, you can bind specific keys or trigger other events
-- --
-- -- 	-- Example: Setting some keybindings for the NvimTree buffer
-- -- 	local opts = { noremap = true, silent = true }
-- --
-- -- 	-- Add custom key mappings for the nvim-tree buffer
-- -- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "a", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree when 'a' is pressed
-- -- end
-- local function on_attach(bufnr)
-- 	local api = require("nvim-tree.api")
-- 	local map = vim.keymap.set

-- 	local function opts(desc)
-- 		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- 	end

-- 	-- default mappings
-- 	api.config.mappings.default_on_attach(bufnr)

-- 	-- custom mappings
-- 	map("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
-- 	map("n", "?", api.tree.toggle_help, opts("Help"))
-- end

-- return {
-- 	{
-- 		"nvim-tree/nvim-tree.lua",
-- 		opts = { on_attach = on_attach, ignore = false },
-- 		-- open it by typing :NvimTreeToggle
-- 		-- and then, you can type "a"

-- 		config = function()
-- 			local map = vim.keymap.set

-- 			map("n", "<leader><leader>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })

-- 			require("nvim-tree").setup({
-- 				view = {
-- 					float = {
-- 						enable = true,
-- 						open_win_config = function()
-- 							local columns = vim.o.columns
-- 							local lines = vim.o.lines

-- 							local width = math.floor(columns * 0.5)
-- 							local height = math.floor(lines * 0.6)

-- 							return {
-- 								relative = "editor",
-- 								border = "rounded",
-- 								width = width,
-- 								height = height,
-- 								row = math.floor((lines - height) / 2),
-- 								col = math.floor((columns - width) / 2),
-- 							}
-- 						end,
-- 					},
-- 					-- Disable default fixed position
-- 					adaptive_size = false,
-- 					side = "left",
-- 					width = 30,
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
