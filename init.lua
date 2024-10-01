-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- load local settings, this is optional and should be used if you want to have
-- a local configuration for your vim setup
require("config.vim")

-- core library, used to load the whole environment (plugins)
require("config.lazy")

-- specific nvim configs, for compability purposes, you should use .vimrc files
-- and if, and only if, you want to configure locally, you can configure it
-- there
require("config.options")

-- load all plugins and also register some of keymaps internally
require("config.plugins")

-- register extra scripts
require("config.scripts")
-- require("scripts.greet")

-- register extra keymaps/shortcuts
require("config.keymaps")
