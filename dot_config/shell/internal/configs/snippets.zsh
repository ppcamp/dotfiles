# vim: ts=2 sts=2 sw=2 et:

# Gist dotfiles
local url="https://gist.githubusercontent.com/ppcamp/a5d7828f3430226b2668b2f29bc38485/raw"
for file in '.gitconfig' '.git-template'; do
  zinit ice \
    atclone"[ -f ~/$file ] && mv ~/$file{,.bk}; cp -f \${PWD}/$file ~/$file" \
    atpull"[ -f ~/$file ] && mv ~/$file{,.bk2}; cp -f \${PWD}/$file ~/$file" \
    nocompile as'null' lucid
  zinit snippet "$url/$file"
done

# Snippets
local url="https://gist.githubusercontent.com/ppcamp/35a692ae77c9afa19fa6dc0add0a2697/raw"
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

# extra file (related to fd-find)
file='.fdignore'
zinit ice \
  atclone"[ -f ~/$file ] && mv ~/$file{,.bk}; cp -f \${PWD}/$file ~/$file" \
  atpull"[ -f ~/$file ] && mv ~/$file{,.bk2}; cp -f \${PWD}/$file ~/$file" \
  nocompile as'null' lucid
zinit snippet "$url/$file"
