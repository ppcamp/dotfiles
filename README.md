# My Dotfiles


## TODO

- [ ] Delete remo ppcamp/nvim
- [ ] Delete repo ppcamp/shell


## Links

- https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/
- https://www.chezmoi.io/


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