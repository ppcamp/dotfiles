# vim: ts=2 sts=2 sw=2 et:

# Snippets
local url="$ZEN/pkg/snippets"
local toclone=(
  'aliases.sh'
  'functions.sh'
  'listenat.sh' ### listenat function (check port for process)
  # 'lll.sh'    ### lll (list with octal repr -- if not using eza)
  # 'trash.sh'  ### trash (rm to trash)
)
for file in $toclone; do
  zinit ice wait"0a" lucid
  zinit snippet "$url/$file"
done
