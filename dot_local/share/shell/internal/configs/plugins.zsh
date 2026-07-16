# vim: ts=2 sts=2 sw=2 et:

local folder=$ZEN/plugins
local ASYNC_PLUGINS=(
  # "zsh-users/zsh-syntax-highlighting.git"    # syntax highlighting
  # "Aloxaf/fzf-tab"                           # fzf tab completion

  "$folder/gh"                                 # gh completion and copilot functions
  "$folder/fzf"                                # add support to fzf keybindings (ctrl+t, alt+c,ctrl+r)
  "zsh-users/zsh-autosuggestions.git"          # virtual suggestions
  "zdharma-continuum/fast-syntax-highlighting" # fast syntax highlighting
  "romkatv/zsh-defer"                          # defer loading of plugins until after the prompt is shown
  "ppcamp/zsh-fzf-rg"                          # rg+fzf search widget with live preview
  "$folder/zoxide"                             # zoxide (cd improved) integration and init
  "$folder/aliases"                            # completion and ctrl+r saving option
  "$folder/tldr"                               # tldr command line widget (ctrl+tldr
  "$folder/env-cache"                          # reloadable env vars caching system (avoid gopass everytime
  "$folder/fancy-ctrl-z"                       # fancy ctrl+z
  "$folder/chezmoi"                            # chezmoi integration
  #"$folder/pet"                               # completion and ctrl+r saving option
)

# load each plugin async (even after the prompt is show).
# NOTE that if you call any of these ASYNC_PLUGINS before they are loaded, you will
# get an error. So be careful with the order of your ASYNC_PLUGINS and the commands
# you use in your .zshrc
for plugin in $ASYNC_PLUGINS; do
  # echo "Loading $plugin"
  # wait"0a" loads 0seconds after prompt is shown, and it does "[a]sync"
  zinit ice wait"0a" lucid
  zinit light "$plugin"
done

local SYNC_PLUGINS=(
  "romkatv/zsh-defer" # defer loading of plugins until after the prompt is shown
  "$folder/env-cache" # reloadable env vars caching system (avoid gopass everytime
)

# load each plugin sync. PREFER AVOIDING THIS, as it will delay the loading of
# your shell. Only use this if you need to use a plugin before the prompt is
# shown.
for plugin in $SYNC_PLUGINS; do
  # echo "Loading $plugin"
  zinit ice lucid
  zinit light "$plugin"
done

# History searcher with prioritazion mechanism (a bit overkill)
# https://github.com/cantino/mcfly?tab=readme-ov-file#database-location
# zinit ice lucid wait"0a" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"'
# zinit light cantino/mcfly
