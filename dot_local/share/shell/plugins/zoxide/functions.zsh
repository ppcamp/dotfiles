# vim: ts=2 sts=2 sw=2 et

#alias 1='cd -1'
# not necessary, since I fixed in cd/z functions, also check for ~- or ~-1 or
# ~-N for zsh mv/cp or cd

# append a minus, so zshell understand the number from dirs
# for `z` you must type -N
cd() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    1="-$1"
  fi

  builtin cd "$1"
}

# also check for (zi)
zr() { zoxide query -l $@ | xargs -r zoxide remove }

z() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    1="-$1"
  fi

  __zoxide_z "$@"
}

# zoxide with fzf support
zz(){ __zoxide_zi $@ } 
