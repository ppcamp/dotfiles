-- vim: ts=2 sts=2 sw=2 et

local load_modules = require("utils.modules").load_folder

require("config.options")
require("core.state")
require("core.lazy") -- bootstrap
require("config.keymaps")
require("config.vim")
load_modules("commands")
