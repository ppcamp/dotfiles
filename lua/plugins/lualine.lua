return {
	{
		-- https://www.nerdfonts.com/cheat-sheet
		"nvim-lualine/lualine.nvim",
		config = function()
			local function clock()
				return os.date(" %Y/%m/%d %H:%M")
			end

			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", { "diff", symbols = { added = " ", modified = " ", removed = " " } } },
					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 1,
							symbols = { modified = " ", readonly = " " },
						},
					},
					lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" }, -- Error status
					lualine_y = { "progress" }, --
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
