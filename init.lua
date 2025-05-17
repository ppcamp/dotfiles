-- vim: ts=2 sts=2 sw=2 et

local load_modules = require("utils.modules").load_folder

-- specific nvim configs, for compability purposes, you should use .vimrc files
-- and if, and only if, you want to configure locally, you can configure it
-- there
require("config.options")

-- core library, used to load the whole environment (plugins)
-- load all plugins and also register some of keymaps internally
require("config.lazy")

-- register extra keymaps/shortcuts
require("config.keymaps")

-- load all autocmds, this is optional and should be used if you want to have
-- require("config.autocmd")

-- load local settings, this is optional and should be used if you want to have
-- a local configuration for your vim setup
require("config.vim")

-- register vim command functions
-- can be used by
-- :CommandName
-- require("config.commands")
load_modules("commands")
