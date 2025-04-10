-- vim: ts=2 sts=2 sw=2 et

-- Line bar showing extra informations

return {
	{
		-- https://www.nerdfonts.com/cheat-sheet
		"nvim-lualine/lualine.nvim",
		config = function()
			local function clock()
				return os.date(" %Y/%m/%d %H:%M")
			end

			local function clock()
				return os.date(" %Y/%m/%d %H:%M")
			end

			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = "",
					section_separators = "", -- { left = "", right = "" },
				},
				sections = {
					lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
					lualine_b = {
						"branch",
						{
							"diff",
							symbols = {
								added = " ",
								modified = " ",
								removed = " ",
							},
						},
						"nvim-dap-ui",
					},
					lualine_c = {
						-- "%=", -- center text section
						{
							"filename",
							file_status = true,
							path = 1,
							symbols = { modified = " ", readonly = " " },
						},
					},
					lualine_x = {
						"nvim-dap-ui",
						"diagnostics",
						"quickfix",
					},
					lualine_y = {
						-- "progress",
						"location",
						"filetype",
						"fileformat",
						"encoding",
					},
					lualine_z = {
						{ clock, separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {
					"lazy",
					"man",
					"mason",
					"nvim-dap-ui",
					"nvim-tree",
					"quickfix",
					"symbols-outline",
				},
			})
		end,
	},
}
