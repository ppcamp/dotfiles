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

-- register extra keymaps/shortcuts
require("config.keymaps")
