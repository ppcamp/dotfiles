# vim: ts=2 sts=2 sw=2 et:

local folder=$ZEN/internal/plugins
local PLUGINS=(
  # "zsh-users/zsh-syntax-highlighting.git"    # syntax highlighting
  # "Aloxaf/fzf-tab"                           # fzf tab completion

  "$folder/gh"                                 # gh completion and copilot functions
  "$folder/fzf"                                # add support to fzf keybindings (ctrl+t, alt+c,ctrl+r)
  "zsh-users/zsh-autosuggestions.git"          # virtual suggestions
  "zdharma-continuum/fast-syntax-highlighting" # fast syntax highlighting
  "ppcamp/zsh-fzf-rg"                          # rg+fzf search widget with live preview
  "$folder/zoxide"                             # zoxide (cd improved) integration and init
  "$folder/pet"                                # completion and ctrl+r saving option
)

# load each plugin
for plugin in $PLUGINS; do
  # echo "Loading $plugin"
  zinit ice wait"0a" lucid
  zinit light "$plugin"
done

# History searcher with prioritazion mechanism (a bit overkill)
# https://github.com/cantino/mcfly?tab=readme-ov-file#database-location
# zinit ice lucid wait"0a" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"'
# zinit light cantino/mcfly
