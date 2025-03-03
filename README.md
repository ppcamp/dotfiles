# nvim

A simple nvim setup for my use


> Based on [kickstart-modular-nvim]


To enable numbering, for vim only

As a suggestion, use a [nerdfont], which contains icons for your files, and after install it,
set it as font that should be used for your terminal emulator, after that, go to `lua/config/options.lua`
and enabled it.

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


See: [Nerdfonts cheatsheet](https://www.nerdfonts.com/cheat-sheet)


[kickstart-modular-nvim]: https://github.com/dam9000/kickstart-modular.nvim
[nerdfont]: https://www.nerdfonts.com/font-downloads
