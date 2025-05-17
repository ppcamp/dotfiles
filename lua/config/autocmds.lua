-- vim: ts=2 sts=2 sw=2 et

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("shell_autocmd", { clear = true })

--#region command: Bash
-- Fold methodology for bash filetypes
autocmd("FileType", {
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
autocmd("BufWritePre", { -- Before writing to the file, run this
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
    local command = vim
      .system({ "shfmt", "-i", "2", "-ci", "-s" }, {
        stdin = buf_lines,
      })
      :wait()

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
--#endregion

--#region command: common_editor
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show diagnostics in the command line when cursor moves
autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", border = "rounded" })
  end,
})
--#endregion

--#region command: Golang - Fix imports
autocmd("BufWritePre", {
  pattern = "*.go",
  command = "silent !goimports -w %",
})
--#endregion

--#region command: Curl
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
--#endregion

--#region command: Curl
--#endregion

--#region command: Format line
-- All extra commands that I think usefull
--
-- Scripts that aren't defined using cmd, will require the `:lua` prefix
-- Add a line with the vim format to the end of the file
cmd("AddVimFormatLine", function()
  local replacement = {
    -- tabstop (ts)       - number of spaces that a <Tab> counts for
    -- softtabstop (sts)  - number of spaces that a <Tab> counts for while editing
    -- shiftwidth (sw)    - number of spaces to use for each step of (auto)indent
    -- expandtab (et)     - use spaces instead of tabs
    -- noexpandtab (noet) - use tabs instead of spaces
    "vim: ts=2 sts=2 sw=2 et",
    "",
  }
  -- local lines = api.nvim_buf_line_count(buf)
  local begin_ = 0 -- lines
  local exclude = 0 -- do not replace any lines

  local buf = api.nvim_get_current_buf()
  local window = api.nvim_get_current_win()

  -- api.nvim_buf_set_lines(buf, lines, lines, false, { text })
  -- api.nvim_win_set_cursor(buf, { lines + 1, 0 })
  api.nvim_buf_set_lines(buf, begin_, exclude, false, replacement)
  api.nvim_win_set_cursor(window, { 1, 0 })
end)
--#endregion

--#region command: RenderCharsDisable
-- Alternativaly, you can try to use od -c file.txt to see the characters
-- or cat -e file.txt or hexdump -C file.txt
cmd("RenderChars", function()
  vim.api.nvim_command("set listchars=tab:»\\ ,eol:¬,trail:•,extends:❯,precedes:❮,nbsp:+,space:·")
  vim.api.nvim_command("set list")

  vim.api.nvim_command("set ff?")
  -- :set fileformat=unix
end)

cmd("RenderCharsDisable", function()
  vim.api.nvim_command("set nolist")
end)
--#endregion
