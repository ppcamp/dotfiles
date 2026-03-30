-- vim: ts=2 sts=2 sw=2 et

local M = {}

---Extend multiples tables
---@param ... table
---@return table<string,any>
M.extend = function(...)
  ---@type table<string,any>
  local result = {}

  for _, t in ipairs({ ... }) do
    for _, v in ipairs(t) do
      table.insert(result, v)
    end
  end

  return result
end

---Get Keys of tables, including function name and things like that.
---@param ... table<string,table>
---@return string[]
M.keys = function(...)
  ---@type string[]
  local keys = {}

  for key in pairs(({ ... })[1]) do
    table.insert(keys, key)
  end

  return keys
end

return M
