# My Dotfiles

> [!TIP]
>
> Installing chezmoi
>
> ```sh
> # Install chezmoi
> sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
>
> # initialize chezmoi (without install)
> chezmoi init --apply https://github.com/ppcamp/dotfiles
> ```


<figure>
  <img src="./docs/imgs/execution.png" alt="chezmoi execution" width="500px">
  <figcaption>ChezMoi execution</figcaption>
</figure>

## TODO

- [ ] Use `install -m 755` for scripts in `.installDirs.main` and `.installDirs.home`
- [ ] Clean up any wrong script installed previously in `/usr/bin/` and `/usr/local/bin/` and `/bin/`
> [!WARNING]
> Some scripts installed the whole tarball in those folders.
- [ ] Fix [lazygit nvim plugins](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins)
- [ ] Delete repo ppcamp/nvim
- [ ] Delete repo ppcamp/shell

## Links

- [chezmoi dotfiles config](https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/)
- [chezmoi]

## Commands

Applying changes to your system:
```sh
# to update
chezmoi init --apply --data=false
```

Extra commands:
```sh
# to change anything
chezmoi add /usr/bin/fzf-git
chezmoi edit-config
chezmoi data
chezmoi cd
```

Clearing state of `chezmoi` scripts:
```sh
# testing template
chezmoi execute-template < run_once_install-asdf.tmpl | bat

# To clear the state of run_onchange_ scripts, run:
chezmoi state delete-bucket --bucket=entryState

# To clear the state of run_once_ scripts, run:
chezmoi state delete-bucket --bucket=scriptState
```

[chezmoi]: https://www.chezmoi.io/


## Notes


<details>
  <summary>
    <b>Breaking changes</b>
  </summary>

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

</details>

## Extras


<details>
  <summary>
    <b>Checking apt deb files</b>
  </summary>

  1. Create a temporary directory
  ```sh
  folder=$(mktemp -d)
  cd ${folder}
  ```

  2. Download the deb file (if not already done)
  ```sh
  apt download <package-name> # e.g., apt download sqlfluff
  ```

  3. Check the contents of the deb file
  ```sh
  dpkg -c <package-name>.deb # e.g., dpkg -c sqlfluff_1.4.5-2_all.deb
  ```

  4. Extract the deb file to a temporary directory
  ```sh
  # Extract the package itself
  dpkg -x <package-name>.deb <content-folder> # e.g., pkg -x sqlfluff_1.4.5-2_all.deb sqlfluff
  # Extract the control files
  dpkg-deb -e <package>.deb <control-folder> # dpkg -e sqlfluff_1.4.5-2_all.deb control
  ```
  4. List the contents of the extracted directory
  ```sh
  ls -l ${folder}
  ```
  6. Check the control files for dependencies and other information
  ```sh
  cat ${folder}/DEBIAN/control
  ```

</details>