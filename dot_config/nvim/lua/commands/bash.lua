-- vim: ts=2 sts=2 sw=2 et

local cmd = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup("shell_autocmd", { clear = true })

-- Fold methodology for bash filetypes
cmd("FileType", {
	desc = "Set foldmethod for bash files",
	group = group,
	pattern = "bash",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr =
			"getline(v:lnum) =~ '^\\s*\\(function\\|[a-zA-Z_][a-zA-Z0-9_]*\\)\\s*(.*)\\s*{$' ? '>' : '<'"
	end,
})

-- Fold methodology for bash filetypes
cmd("BufWritePre", { -- Before writing to the file, run this
	pattern = "*.sh,*.zsh",
	group = group,

	-- WARN: if using this, needs to reload from buffer-
	-- command = "silent !shfmt -i 2 -ci -w %",

	-- Read the output of shfmt and replace the current buffer with it
	-- WARN: it will lose all context if error
	-- command = "%!shfmt -i 2 -ci -s",

	callback = function(args)
		local bufnr = args.buf

		-- Run shfmt on the buffer content
		local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local content = table.concat(buf_lines, "\n")

		-- Run the command and capture errors
		local command = vim.system({ "shfmt", "-i", "2", "-ci", "-s" }, {
			stdin = buf_lines,
		}):wait()

		-- local result = vim.fn.system(c, content)
		-- local exit_code = vim.v.shell_error

		if command.code ~= 0 then
			print("shfmt failed: " .. command.stderr)

			-- Formatting failed; notify and cancel write
			-- vim.notify("shfmt failed: " .. result, vim.log.levels.ERROR)
			-- Prevent buffer from being saved
			-- vim.cmd("setlocal modified")
			-- vim.cmd("echoerr 'shfmt failed; write canceled'")
		else
			-- Formatting succeeded; replace buffer content with formatted output
			local lines = vim.split(command.stdout, "\n")
			lines[#lines] = nil -- Remove the last empty line

			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
		end
	end,
})
