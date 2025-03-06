return {
	{
		-- https://www.nerdfonts.com/cheat-sheet
		"nvim-lualine/lualine.nvim",
		config = function()
			local function clock()
				return os.date(" %Y/%m/%d %H:%M")
			end

			local function curr_cursor_pos()
				local row, col = unpack(vim.api.nvim_win_get_cursor(0))
				-- formats the cursor position as line:column
				return string.format("%d:%d", row, col)
			end

			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"branch",
						{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
					},
					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 1,
							symbols = { modified = " ", readonly = " " },
						},
					},
					lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" }, -- Error status
					lualine_y = {
						"progress",
						curr_cursor_pos,
					},
					lualine_z = {
						--"location",
						{ clock, color = { fg = "#ffffff", bg = "gray" } }, --, gui = "bold"
					},
				},
			})
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
