-- Telescope allow you to have a dynamic fuzzy finder for a lot of terms,
-- such as keymaps, words, symbols, files, and so goes on.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")

			---Alternative to map
			---@param keys string
			---@param func function | string
			---@param desc string
			---@param mode string?
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { desc = "Telescope: " .. desc })
			end

			map("<leader>tt", "<cmd> Telescope <cr>", "Open")
			map("<leader>tc", "<cmd> Telescope commands<cr>", "Commands")
			map("<leader>sm", "<cmd> Telescope man_pages<cr>", "Man pages")

			map("<leader>sh", builtin.help_tags, "Help")
			map("<leader>sf", builtin.find_files, "Find Files")
			map("<leader>st", builtin.grep_string, "Find current Word")
			map("<leader>sw", builtin.live_grep, "Find by Grep")
			map("<leader>sr", builtin.resume, "Resume")
			map("<leader>s.", builtin.oldfiles, "Find Recent Files ('.' for repeat)")
			map("<leader>sb", builtin.buffers, "Find in all existing buffers")

			map("<leader>tk", builtin.keymaps, "Keymaps")

			-- Slightly advanced example of overriding default behavior and theme
			map("<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, "Search in current buffer")

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			map("<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, "Search / in Open Files")

			--
			-- Shortcut for searching your Neovim configuration files
			map("<leader>tn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, "Telescope search Neovim files")
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
