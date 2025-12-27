# vim: ts=2 sts=2 sw=2 et:

# reload everything (rebuild aliases and functions)
# usually required when updating snippet
function zreload() {
  zinit delete --all
  # zinit self-update       # only if plan to update it
  zinit update --all # everything
  # zinit update --snippets # snippets only
}

function cz-upgrade-tools() {
  (
    cd $HOME/.local/share/chezmoi/.chezmoiscripts
    for script in *;do
      chezmoi execute-template < $script | zsh
    done
  )
}

function funcdescr() {
  function $1 | tr -d '\t\n'
}

# list aliases and grep from args
function agr() {
  alias | rg $@
}

# grep lines to copy
function grepln() {
  sed -n "$1,$2p" $3 | xcp
}

# append a minus, so zshell understand the number from dirs
# for `z` you must type -N
function cd() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    1="-$1"
  fi

  builtin cd "$1"
}

function z() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    1="-$1"
  fi

  __zoxide_z "$@"
}
