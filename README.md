# nvim

A simple nvim setup for my use


> Based on [kickstart-modular-nvim]


To enable numbering, for vim only

file: `~/.vimrc`

```.vimrc
set number " numbering
set sw=4  " used for indentation operations
set ts=4  " how many spaces a tab character represents
set ignorecase
set expandtab

" Use ripgrep (rg) for :grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" Set the format for parsing grep output (%file %line %column %match)
set grepformat=%f:%l:%c:%m
```


As a suggestion, use a [nerdfont], which contains icons for your files, and after install it,
set it as font that should be used for your terminal emulator, after that, go to `lua/config/options.lua`
and enabled it.

1. Install neovim https://github.com/neovim/neovim/blob/master/INSTALL.md
    ```bash
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    ```
2. Clone this repo
    ```bash
    git clone https://github.com/ppcamp/nvim --recursive ~/.config/nvim
    # or, alternativaly
	git clone git@github.com:ppcamp/nvim.git ~/.config/nvim
	```
3. Run `nvim .`

[kickstart-modular-nvim]: https://github.com/dam9000/kickstart-modular.nvim
[nerdfont]: https://www.nerdfonts.com/font-downloads
