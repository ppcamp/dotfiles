__fancy_ctrl_z() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
  fi
}

zle -N __fancy_ctrl_z

bindkey '^Z' __fancy_ctrl_z
