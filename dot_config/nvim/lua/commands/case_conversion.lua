-- vim: ts=2 sts=2 sw=2 et

local cmd = require("utils.command").command
local api = vim.api

-- Helper: split text into words (handles various separators)
local function split_words(text)
  local words = {}
  local current_word = ""

  for i = 1, #text do
    local char = text:sub(i, i)
    local is_separator = char:match("[%s%-%_%.]+") ~= nil
    local is_upper = char:match("[A-Z]") ~= nil

    if is_separator then
      if current_word ~= "" then
        table.insert(words, current_word)
        current_word = ""
      end
    elseif is_upper and current_word ~= "" and current_word:match("[a-z]") then
      table.insert(words, current_word)
      current_word = char
    else
      current_word = current_word .. char
    end
  end

  if current_word ~= "" then
    table.insert(words, current_word)
  end

  return words
end

-- Conversion functions
local conversions = {
  PascalCase = function(text)
    local words = split_words(text)
    local result = ""
    for _, word in ipairs(words) do
      result = result .. word:sub(1, 1):upper() .. word:sub(2):lower()
    end
    return result
  end,

  camelCase = function(text)
    local words = split_words(text)
    local result = ""
    for i, word in ipairs(words) do
      if i == 1 then
        result = word:lower()
      else
        result = result .. word:sub(1, 1):upper() .. word:sub(2):lower()
      end
    end
    return result
  end,

  snake_case = function(text)
    local words = split_words(text)
    return table.concat(words, "_"):lower()
  end,

  kebab_case = function(text)
    local words = split_words(text)
    return table.concat(words, "-"):lower()
  end,

  dot_case = function(text)
    local words = split_words(text)
    return table.concat(words, "."):lower()
  end,

  CONSTANT_CASE = function(text)
    local words = split_words(text)
    return table.concat(words, "_"):upper()
  end,
}

-- Get selected text in visual mode
local function get_visual_selection()
  local start_line = vim.fn.line("'<") - 1
  local start_col = vim.fn.col("'<") - 1
  local end_line = vim.fn.line("'>") - 1
  local end_col = vim.fn.col("'>'")

  local lines = api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

  if #lines == 0 then
    return ""
  end

  if #lines == 1 then
    return lines[1]:sub(start_col + 1, end_col)
  end

  -- Multiple lines
  lines[1] = lines[1]:sub(start_col + 1)
  lines[#lines] = lines[#lines]:sub(1, end_col)
  return table.concat(lines, "\n")
end

-- Replace selected text
local function replace_visual_selection(new_text)
  local start_line = vim.fn.line("'<") - 1
  local start_col = vim.fn.col("'<") - 1
  local end_line = vim.fn.line("'>") - 1
  local end_col = vim.fn.col("'>'")

  local lines = api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

  if #lines == 0 then
    return
  end

  if #lines == 1 then
    local line = lines[1]
    lines[1] = line:sub(1, start_col) .. new_text .. line:sub(end_col + 1)
  else
    -- Multiple lines: reconstruct properly
    local new_lines = vim.split(new_text, "\n")
    lines[1] = lines[1]:sub(1, start_col) .. new_lines[1]
    for i = 2, #new_lines - 1 do
      table.insert(lines, i, new_lines[i])
    end
    if #new_lines > 1 then
      table.insert(lines, new_lines[#new_lines] .. lines[end_line - start_line + 1]:sub(end_col + 1))
    end
  end

  api.nvim_buf_set_lines(0, start_line, end_line + 1, false, lines)
end

-- Get current word
local function get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

-- Replace word under cursor
local function replace_word_under_cursor(new_text)
  local word = get_word_under_cursor()
  local line_num = vim.fn.line(".") - 1
  local line = api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
  local start_col = vim.fn.col(".") - 1
  local end_col = start_col + #word

  local new_line = line:sub(1, start_col) .. new_text .. line:sub(end_col + 1)
  api.nvim_buf_set_lines(0, line_num, line_num + 1, false, { new_line })
end

-- Create commands for each conversion
for name, convert_fn in pairs(conversions) do
  local cmd_name = "To" .. name:gsub("_", "")
  if name == "CONSTANT_CASE" then
    cmd_name = "ToConstantCase"
  end

  cmd(cmd_name, function(opts)
    local text
    if opts.range == 2 then
      -- Visual mode
      text = get_visual_selection()
      local converted = convert_fn(text)
      replace_visual_selection(converted)
    else
      -- Normal mode - convert current word
      text = get_word_under_cursor()
      local converted = convert_fn(text)
      replace_word_under_cursor(converted)
    end
  end, { range = "%" })
end
