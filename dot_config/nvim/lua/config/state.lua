-- vim: ts=2 sts=2 sw=2 et

-- add a global state to the config
local M = {
  icons = require("utils.icons"),
  map = require("utils.map").map,
}

_G.State = M
