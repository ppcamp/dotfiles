# My Dotfiles

> [![GitHub license](https://img.shields.io/github/license/ppcamp/dotfiles)]
>
> A collection of my dotfiles, scripts, and configuration files managed by [chezmoi](https://www.chezmoi.io/).

<figure>
  <img width="578" height="377" alt="execution" src="https://github.com/user-attachments/assets/8e3f0e70-8778-4505-aa6c-2a608017fdee" />
  <figcaption>ChezMoi execution</figcaption>
</figure>

## Installation


> [!TIP]
>
> Installing chezmoi
>
> ```sh
> # Install chezmoi
> sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
>
> export PATH="$PATH:$HOME/.local/bin"
>
> # initialize chezmoi (without install)
> chezmoi init --apply https://github.com/ppcamp/dotfiles
>
> # re-execute all scripts
> # chezmoi state delete-bucket --bucket=scriptState
> ```

> [!IMPORTANT]
> ChezMoi requires `git` and `git-lfs` to work properly, so make sure to have
> them installed before running the above commands.

> [!TIP]
>
> Avoid to use `snaps`, since they are much slower than native and flatpak, and
> often buggy (even more in older versions).

## Docs

```
docs/
├── Apt Package Inspection.md
├── ASDF.md
├── Chezmoi Commands.md
├── Debloat brave.md
├── Discord Webhooks.md
├── dot_golangci.yml
├── dot_lefthook.yaml
├── Git Config.md
├── GRUB.md
├── imgs
│   └── execution.png
├── Kitty.md
├── Nvim.md
├── programs
│   └── Programs for linux-bash-zsh.md
└── zshrc config.md
```




## Flatpak

> [!TIP]
>
> Install [flatseal] to control flatpak permissions and configs. [bazaar] to `flatpak` store

## Links
- [chezmoi dotfiles config]
- [chezmoi]
- [sprig] (Golang extra functions library that can be used in these templates)

<!-- Links -->
[sprig]: https://masterminds.github.io/sprig/
[lazygit nvim plugins]: https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins
[chezmoi]: https://www.chezmoi.io/
[chezmoi dotfiles config]: https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/
[flatseal]: https://flathub.org/pt-BR/apps/com.github.tchx84.Flatseal
