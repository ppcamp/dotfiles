# vim: ts=2 sts=2 sw=2 et:

# reload everything (rebuild aliases and functions)
# usually required when updating snippet
zreload() {
  zinit delete --all
  # zinit self-update       # only if plan to update it
  zinit update --all # everything
  # zinit update --snippets # snippets only
}

cz-upgrade-tools() {
  (
    cd $HOME/.local/share/chezmoi/.chezmoiscripts
    for script in *;do
      if [[ -z $1 ||  "$script" == *"$1"* ]]; then
        chezmoi execute-template < $script | zsh
      fi
    done
  )
}

echoerr() { echo "$@" 1>&2 && return 1 }

funcdescr() {
  function $1 | tr -d '\t\n'
}

# list aliases and grep from args
agr() {
  alias | rg $@
}

# grep lines to copy
grepln() {
  sed -n "$1,$2p" $3 | xcp
}

# append a minus, so zshell understand the number from dirs
# for `z` you must type -N
cd() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    1="-$1"
  fi

  builtin cd "$1"
}

z() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    1="-$1"
  fi

  __zoxide_z "$@"
}


colorss() {
  color1=$(tput setaf 12)
  printf '-%.0s' {1..80}
  echo
  printf "Colors"
  echo
  tput bold
  printf "${color1}Usage:\nSee \`function colors\`\n"
  tput sgr0
  for i in {0..255}; do
    tput setaf $i
    echo -n "Cor $i "
    if [ $((($i + 1) % 8)) -eq 0 ]; then echo; fi
  done

  tput sgr0
}

zebra() {
    # NR: Line number
    # \033[48;5;235m: Set background to dark gray (235)
    # \033[K: Clears to the end of the line (essential for full-width striping)
    awk '{
        if (NR % 2 == 0)
            printf "\033[48;5;240m%s\033[K\033[0m\n", $0;
        else
            print $0;
    }'
}

http() {
  local file="$1"
  local entry_name="$2"
  local vars=()

  if [[ -z "$file" ]]; then
    echo "Usage: hrun <file.hurl> [entry-name] [hurl args...]"
    return 1
  fi

  if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    return 1
  fi

  # load all variables from entry as --variable key=value
  while IFS='=' read -r key val; do
    vars+=(--variable "${key}=${val}")
  done < <(env)


  if [[ -n $entry_name ]]; then
    # acha o número da entry pelo nome no comentário
    local entry_num
    entry_num=$(grep -n "^### " "$file" | grep -i "$entry_name" | head -1 | cut -d: -f1)

    if [[ -z $entry_num ]]; then
      echo "entry '$entry_name' não encontrada em $file"
      return 1
    fi

    # converte linha para índice de entry (cada entry começa com "# ")
    local idx
    idx=$(grep -n "^### " "$file" | grep -n "$entry_name" | head -1 | cut -d: -f1)

    hurl "${vars[@]}" --from-entry "$idx" --to-entry "$idx" "${@:3}" "$file"
  else
    hurl "${vars[@]}" "${@:2}" "$file"
  fi
}

