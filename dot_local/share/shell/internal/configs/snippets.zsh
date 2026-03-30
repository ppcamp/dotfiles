# vim: ts=2 sts=2 sw=2 et:

# Snippets
local url="$ZEN/snippets"
local files=("${(f)$(ls $url/*)}")

local blacklist=(
  # 'aliases.sh'           ### my custom aliases
  # 'functions.sh'         ### my custom functions
  # 'listenat.sh'          ### listenat function (check port for process)
  'lll.sh'                 ### lll (list with octal repr -- if not using eza)
  'trash.sh'               ### trash (rm to trash)
)

for file in ${files[@]}; do
  local basename="${file:t}"
  if [[ " ${blacklist[@]} " =~ " ${basename} " ]]; then
    #echo "$(tput setaf 240)Skipping $(tput setaf 245)$basename $(tput setaf 240)(blacklisted)"
    continue
  fi

  zinit ice wait"0" lucid
  zinit snippet "$file"
done
