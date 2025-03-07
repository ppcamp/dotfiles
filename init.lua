-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- core library, used to load the whole environment (plugins)
require("config.lazy")

-- register extra scripts
require("config.scripts")

-- specific nvim configs, for compability purposes, you should use .vimrc files
-- and if, and only if, you want to configure locally, you can configure it
-- there
require("config.options")

-- load local settings, this is optional and should be used if you want to have
-- a local configuration for your vim setup
require("config.vim")

-- load all plugins and also register some of keymaps internally
require("config.plugins")

-- register extra keymaps/shortcuts
require("config.keymaps")

-- vim: ts=2 sts=2 sw=2 et
