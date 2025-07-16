__FZF_CTRL_R_HEADER=$(echo $FZF_CTRL_R_OPTS | grep -oP "(?<=--header ')[^']*")

export FZF_CTRL_R_OPTS="
  ${FZF_CTRL_R_OPTS}
  --header 'alt+s (pet new) |'
  --bind 'alt-s:execute(pet new --tag {2..})+abort'"

############################# Search in your pet config bookmarks
pet-view() {
  local query=$LBUFFER              # keep previous cmdline value
  zle -I                            # Clears any pending input/output
  BUFFER=""                         # Clears the line buffer
  zle accept-line                   # Refresh/remove line buffer (previous data)
  pet exec --color --query="$query" # run query with previous cmd value
  # pet cannot run in a subshell, aka $(), otherwise it won't identify as TTY
  # and thus, won't put color in the output.
}
zle -N pet-view
bindkey '^s' pet-view
