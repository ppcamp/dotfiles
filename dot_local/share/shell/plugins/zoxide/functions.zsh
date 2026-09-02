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
zo(){ __zoxide_zi $@ } 

_ZO_MAXAGE=100
_ZO_EXCLUDE_DIRS="$HOME:$HOME/.config/*:/tmp:/usr/*:/opt/*:/share/*"
_ZO_DATA_DIR="$HOME/.cache/zoxide"
# show a tree view (instead of the default `ls -Cp`) in the zi/zz fzf preview
_ZO_FZF_OPTS="--color header:bold --cycle --multi --height 100% --reverse --info=right --preview-window=right,70% --preview='\command -p tree -C -L 2 {2..}'"
# _ZO_FZF_OPTS="--preview 'eza --tree --level=2 --color=always --icons=auto --git-ignore {2..}' --preview-window=right,50%,border-left"
