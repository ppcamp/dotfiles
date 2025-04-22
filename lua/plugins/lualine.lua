-- vim: ts=2 sts=2 sw=2 et

-- Line bar showing extra informations

return {
	{
		-- https://www.nerdfonts.com/cheat-sheet
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				dependencies = { "neovim/nvim-lspconfig" },
			},
		},
		config = function()
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
						{
							"filename",
							file_status = true,
							-- path = 4, -- filename and path (0:filename, 1:relative path)
							path = 0,
							symbols = { modified = " ", readonly = " " },
						},
						"%=", -- center text section
						{
							"navic",
							color_correction = nil,
							navic_opts = {
								highlight = true,
								depth_limit = 3,
								separator = "  ",
								click = true,
							},
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
