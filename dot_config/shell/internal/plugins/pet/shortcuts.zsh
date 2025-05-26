__FZF_CTRL_R_HEADER=$(echo $FZF_CTRL_R_OPTS | grep -oP "(?<=--header ')[^']*")

export FZF_CTRL_R_OPTS="
  ${FZF_CTRL_R_OPTS}
  --header 'alt+s (pet new) |'
  --bind 'alt-s:execute(pet new --tag {2..})+abort'"

############################# Search in your pet config bookmarks
# The command below requires PET to be installed
function pet-select() {
  BUFFER=$(pet search  --color --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select
