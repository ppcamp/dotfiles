-- vim: ts=2 sts=2 sw=2 et

-- Scripts that aren't defined using cmd, will require the `:lua` prefix
local cmd = require("utils.command").command
local Greet = require("utils.scripts.greet-user").Greet

cmd("GreetUser", function(opts)
	Greet(opts.args)
end, { nargs = 1 })
