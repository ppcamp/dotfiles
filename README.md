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



## TODO

- [ ] Fix [lazygit nvim plugins](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins)
- [ ] Delete remo ppcamp/nvim
- [ ] Delete repo ppcamp/shell

## Links

- [chezmoi dotfiles config](https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/)
- [chezmoi]

## Commands

```sh
# to update
chezmoi init --apply --data=false

# to change anything
chezmoi add /usr/bin/fzf-git
chezmoi edit-config
chezmoi data
chezmoi cd
```

[chezmoi]: https://www.chezmoi.io/


## Notes


<details>
  <summary>
    <b>Breaking changes</b>
  </summary>

1. You must run

```sh
echo "Removing previous binaries from /usr/bin, they now will be in /usr/local/bin"
sudo rm -rf rg fd bat xcp xpb lazygit hyperfine gitx shfmt asdf diffstatic zoxide tlrc choose fzf
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