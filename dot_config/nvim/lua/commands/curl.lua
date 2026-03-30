-- vim: ts=2 sts=2 sw=2 et

local cmd = require("utils.command").command
local api = vim.api

---@class Arg
---@field fargs string[] The arguments passed to the command
cmd("Curl", function(args)
	if #args.fargs < 1 then
		print("Usage: Curl <url>")
		return
	end

	local url = args.fargs[1]
	local curl = "%!curl -sLo - " .. url
	api.nvim_command(curl)
end, { nargs = 1 })
