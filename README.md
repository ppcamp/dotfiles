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

