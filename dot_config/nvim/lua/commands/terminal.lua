-- vim: ts=2 sts=2 sw=2 et

-- Send a visual selection (v, V or CTRL-V) to a terminal and run it.
-- The target is the terminal buffer that had focus last, so it also works from
-- a terminal's own scrollback (<Esc><Esc>, select, send) to re-run a command.

local group = vim.api.nvim_create_augroup("terminal_run", { clear = true })

---Last terminal buffer that had focus.
---@type integer|nil
local last_term = nil

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  desc = "Remember the last focused terminal buffer",
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype == "terminal" then
      last_term = args.buf
    end
  end,
})

---Job id of a terminal buffer, when its job is still running.
---@param buf integer|nil Buffer to inspect
---@return integer|nil
local function job_of(buf)
  if not buf or not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "terminal" then
    return nil
  end

  local job = vim.b[buf].terminal_job_id
  if job and vim.fn.jobwait({ job }, 0)[1] == -1 then -- -1 means still running
    return job
  end
end

---Job to send to: the last focused terminal, any other live one, or a new split.
---@return integer|nil
local function target()
  local job = job_of(last_term)
  if job then
    return job
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    job = job_of(buf)
    if job then
      last_term = buf
      return job
    end
  end

  local win = vim.api.nvim_get_current_win()
  vim.cmd("botright 15split | terminal")
  last_term = vim.api.nvim_get_current_buf()
  vim.api.nvim_set_current_win(win)
  return job_of(last_term)
end

---Send the visual selection to the terminal, each line followed by a newline so
---the shell runs it.
local function run()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false) -- leave visual mode

  local job = target()
  if not job then
    vim.notify("No terminal available to run the selection", vim.log.levels.WARN)
    return
  end

  vim.fn.chansend(job, table.concat(lines, "\n") .. "\n")
end

State.map("<leader>tr", run, "Run selection in terminal", "x")
