# vim: ts=2 sts=2 sw=2 et

# zmodload zsh/zprof #debugging (use along with zprof)

export ZEN="${0:a:h}"
export ZINIT_HOME=$ZEN/zinit
local internal="$ZEN/internal/"

# load utils
source "${ZINIT_HOME}/zinit.zsh"
source $ZEN/internal/utils/loaders.zsh # load path loaders functions

# needs to be loaded in this order
source "$internal/configs/paths.zsh"       # include paths
source "$internal/configs/variables.zsh"   # exports
source "$internal/configs/configs.zsh"     # shell configs
source "$internal/configs/plugins.zsh"     # zsh plugins loading
source "$internal/configs/shortcuts.zsh"   # shortcuts
source "$internal/configs/snippets.zsh"    # default snippets loading
source "$internal/configs/completions.zsh" # default snippets loading

# zprof #debugging

source "$internal/plugins/starship/starship.zsh" # starship prompt
