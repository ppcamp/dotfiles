# nvim basic setup

A simple nvim setup for my use.

**When using `vim-go`, type `GoInstallBinaries` to install required tools**

> [!TIP]
> Check the [plugins](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins) in LazyVim

> [!NOTE]
>
> Based on [kickstart-modular-nvim], [lazyvim-pm], [Lazyvim] with some
> modifications.

> [!TIP]
>
> [Check my gist with tips for vim][gist], and 
> [Vim shortcuts and tips]
>
> As a suggestion, use a [nerdfont], which contains icons for your files, and after install it,
> set it as font that should be used for your terminal emulator, after that, go to `lua/config/options.lua`
> and enabled it.

---

## Setup

1. Install neovim https://github.com/neovim/neovim/blob/master/INSTALL.md
    ```bash
    # Download and install nvim
    sudo rm -rf /opt/nvim && curl -sLo - https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz  | sudo tar -xz -C /opt
    ```
2. Clone this repo
    ```bash
    git clone https://github.com/ppcamp/nvim --recursive ~/.config/nvim
    # or, alternativaly
	git clone git@github.com:ppcamp/nvim.git ~/.config/nvim
	```
3. Run `nvim .`

---

## Extras

See: [Nerdfonts cheatsheet](https://www.nerdfonts.com/cheat-sheet)

For nvim to work with sudo account, you'll need to create a copy or a link into the `root/home` directory
`sudo ln -s /opt/nvim-config /root/.config/nvim`


https://github.com/folke/noice.nvim

## To remove it 

```sh
# Linux / MacOS (unix)
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

# Flatpak (linux)
rm -rf ~/.var/app/io.neovim.nvim/config/nvim
rm -rf ~/.var/app/io.neovim.nvim/data/nvim
rm -rf ~/.var/app/io.neovim.nvim/.local/state/nvim

# Windows CMD
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data

# Windows PowerShell
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data
```

<!----------------------------------------------------------------------------->
[kickstart-modular-nvim]: https://github.com/dam9000/kickstart-modular.nvim
[nerdfont]: https://www.nerdfonts.com/font-downloads
[gist]: https://gist.github.com/ppcamp/40ad98ab0622324e751fedb4504061c8
[Vim shortcuts and tips]: https://gist.github.com/ppcamp/40ad98ab0622324e751fedb4504061c8
[lazyvim-pm]: https://lazy.folke.io/spec
[lazyvim]: https://www.lazyvim.org/
