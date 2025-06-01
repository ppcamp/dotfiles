# Breaking changes


1. You must run

```sh
echo "Removing previous binaries from /usr/bin and /bin, they now will be in /usr/local/bin"
binaries=(
  "bat"
  "btop"
  "choose"
  "diffstatic"
  "eza"
  "fd"
  "fzf"
  "gitx"
  "gum"
  "hyperfine"
  "just"
  "lazygit"
  "pet"
  "procs"
  "rg"
  "sd"
  "shfmt"
  "tlrc"
  "xcp"
  "xpb"
)
for bin in $binaries; do
  # --hidden to include hidden files
  for result in $(fd --exclude '/mnt/' -tx "^$bin\$" /); do
    sudo rm -i "$result"
  done
done
```