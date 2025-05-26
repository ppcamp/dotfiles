# My Dotfiles

> [!TIP]
>
> Installing chezmoi
> ```sh
> sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:ppcamp/dotfiles.git
> ```


## TODO

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