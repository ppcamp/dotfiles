# vim: ts=2 sts=2 sw=2 et:

echoerr() { echo "$@" 1>&2 && return 1 }

funcdescr() { function $1 | tr -d '\t\n' }

# list aliases and grep from args
agr() { alias | rg $@ }

# Copy range of lines of file, Example: < grepln 1 10 file >
grepln() { sed -n "$1,$2p" $3 | xcp }

zebra() {
  # NR: Line number
  # \033[48;5;235m: Set background to dark gray (235)
  # \033[K: Clears to the end of the line (essential for full-width striping)
  local zebra_awk='{
        if (NR % 2 == 0)
            printf "\033[48;5;240m%s\033[K\033[0m\n", $0;
        else
            print $0;
    }'

  if [[ -t 0 ]]; then
    ls | awk "$zebra_awk"
  else
    awk "$zebra_awk"
  fi
}

http() {
  local file="$1"
  local entry_name="$2"
  local vars=()

  if [[ -z $file ]]; then
    echo "Usage: hrun <file.hurl> [entry-name] [hurl args...]"
    return 1
  fi

  if [[ ! -f $file ]]; then
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
    if [ $(((i + 1) % 8)) -eq 0 ]; then echo; fi
  done

  tput sgr0
}

# `git wcd <branch>` jumps to one of the worktrees of the current repository.
# It lives here instead of next to `git wa`/`git wr` in ~/.gitconfig because a
# git alias runs in a child process and cannot change the shell's directory.
# <branch> is the branch the worktree has checked out, or, for a detached one,
# the worktree directory name. Completion: $ZEN/completions/_git-wcd
# example: <git wcd feature/login> -> ~/.git-worktrees/myrepo-feature-login
git() {
  [[ $1 == wcd ]] || { command git "$@"; return }

  local name=$2
  if [[ -z $name ]]; then
    echoerr "usage: git wcd <branch|worktree>"
    return 1
  fi

  local -a entries
  local entry line dir branch porcelain
  porcelain=$(command git worktree list --porcelain 2>/dev/null)
  entries=(${(ps:\n\n:)porcelain})

  for entry in $entries; do
    dir='' branch=''
    for line in ${(f)entry}; do
      case $line in
      'worktree '*) dir=${line#worktree } ;;
      'branch '*) branch=${${line#branch }#refs/heads/} ;;
      esac
    done
    if [[ $name == "$branch" || $name == "${dir:t}" ]]; then
      cd "$dir"
      return
    fi
  done

  echoerr "no worktree for '$name'"
}
