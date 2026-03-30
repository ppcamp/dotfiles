# echo aliases | entr 'source ./aliases'
# echo aliases | entr /_
# echo aliases | entr -rnc /_

__writeInShellBuff() {
  val=$1

  # get the part before space
  val="${val%% *}"

  # if fzf returned an error, reset prompt, (avoid hanging cursor)
  if (($? != 0)); then
    zle reset-prompt # refresh the prompt
  fi

  # check when calling the function if we are in interactive mode
  if [[ -o interactive ]]; then
    LBUFFER="$val" # append to the left of the cursor
    zle redisplay  # refresh the prompt (replace LBUFFER content)
  fi
}

__aliasesFZFSearcher() {
  formatted=()

  alias | while IFS= read -r line; do
    # Remove leading "alias "
    line="${line#alias }"
    # Split at the first '='
    name="${line%%=*}"
    value="${line#*=}"

    # Pad the name to 25 characters
    # Apply color to the name (e.g., green)
    colored_name="$(printf '\e[35m%-25s\e[0m' "$name")"

    # Combine colored name with value
    formatted+=("$colored_name $value")
  done

  printf '%s\n' "${formatted[@]}"
}

__fzfSearch() {
  query="$1"
  input=$(__aliasesFZFSearcher)

  # Feed to fzf
  val=$(
    fzf \
      --ansi \
      --height=40% \
      --layout=reverse \
      --border \
      --query="$query" \
      --preview='echo {}' \
      --preview-window='up:3:hidden:wrap' \
      --header='' \
      --header-lines 0 \
      --extended \
      --border-label '  💾 Searcher  ' \
      --color=fg:white,bg:black,fg+:green,bg+:black,pointer:green,hl:yellow,hl+:yellow \
      <<<$input
  )

  __writeInShellBuff $val
}

zle -N __fzfSearch
bindkey '^s' __fzfSearch
