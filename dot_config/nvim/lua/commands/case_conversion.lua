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

-- Get selected text range in visual mode
local function get_visual_range()
  local start_line = vim.fn.line("'<") - 1
  local start_col = vim.fn.col("'<") - 1
  local end_line = vim.fn.line("'>") - 1
  local end_col = vim.fn.col("'>'")
  return start_line, start_col, end_line, end_col
end

-- Replace selected text in visual mode (multiple lines handled line by line)
local function replace_visual_selection(convert_fn)
  local start_line, start_col, end_line, end_col = get_visual_range()
  local lines = api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

  if #lines == 0 then
    return
  end

  local result = {}

  if #lines == 1 then
    -- Single line: convert selected text only
    local line = lines[1]
    local selected = line:sub(start_col + 1, end_col)
    local converted = convert_fn(selected)
    result[1] = line:sub(1, start_col) .. converted .. line:sub(end_col + 1)
  else
    -- Multiple lines: convert each line independently
    for i, line in ipairs(lines) do
      if i == 1 then
        -- First line: convert from start_col to end
        local prefix = line:sub(1, start_col)
        local text_to_convert = line:sub(start_col + 1)
        result[i] = prefix .. convert_fn(text_to_convert)
      elseif i == #lines then
        -- Last line: convert from start to end_col
        local text_to_convert = line:sub(1, end_col)
        local suffix = line:sub(end_col + 1)
        result[i] = convert_fn(text_to_convert) .. suffix
      else
        -- Middle lines: convert entire line
        result[i] = convert_fn(line)
      end
    end
  end

  api.nvim_buf_set_lines(0, start_line, end_line + 1, false, result)
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

-- Create commands and keybindings for each conversion
local keybindings = {
  PascalCase = "p",
  camelCase = "c",
  snake_case = "s",
  kebab_case = "k",
  dot_case = "d",
  CONSTANT_CASE = "C",
}

for name, convert_fn in pairs(conversions) do
  local cmd_name = "To" .. name:gsub("_", "")
  if name == "CONSTANT_CASE" then
    cmd_name = "ToConstantCase"
  end

  -- Create user command (for direct use)
  cmd(cmd_name, function(opts)
    if opts.range == 2 then
      -- Visual mode - convert lines independently
      replace_visual_selection(convert_fn)
    else
      -- Normal mode - convert current word
      local text = get_word_under_cursor()
      local converted = convert_fn(text)
      replace_word_under_cursor(converted)
    end
  end, { range = "%" })

  -- Create keybindings with <leader>f (supports macros, repeat, :norm)
  local key = keybindings[name]
  if key then
    -- Normal mode binding
    vim.keymap.set(
      "n",
      "<leader>f" .. key,
      function()
        local text = get_word_under_cursor()
        local converted = convert_fn(text)
        replace_word_under_cursor(converted)
      end,
      { noremap = true, silent = true }
    )

    -- Visual mode binding - use command with range
    vim.keymap.set(
      "x",
      "<leader>f" .. key,
      ":<C-u>'" .. "<" .. ",'>" .. cmd_name .. "<CR>",
      { noremap = true, silent = true }
    )
  end
end
