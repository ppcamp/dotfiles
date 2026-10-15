# vim: ts=2 sts=2 sw=2 et:

# Load completions
# INFO: already done by carapace (if used - see bottom of this file)
fpath+=("$ZEN/completions")

# `git wcd` is a shell function (see snippets/functions.sh), not a git alias nor a
# git-* executable, so _git would never offer it as a sub-command name.
zstyle ':completion:*:*:git:*' user-commands wcd:'jump to a worktree of the current repository'

# Use modern completion system
# autoload -Uz compinit # already done by zinit

zinit ice lucid wait blockf atinit"zpcompinit" # fast version of `compinit` execution
zinit light zsh-users/zsh-completions          # additional completions
