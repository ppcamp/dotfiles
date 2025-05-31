# vim: ts=2 sts=2 sw=2 et:

# Load completions
# INFO: already done by carapace (if used - see bottom of this file)
fpath+=("$ZEN/internal/completions")

# Use modern completion system
# autoload -Uz compinit # already done by zinit

zinit ice lucid wait blockf atinit"zpcompinit" # fast version of `compinit` execution
zinit light zsh-users/zsh-completions          # additional completions
