# vim: ts=2 sts=2 sw=2 et:

############################## PATH
# set PATH so it includes user's private bin if it exists
add_path_if_exist "$HOME/.local/bin"

############################## neovim
add_path_if_exist '/opt/nvim-linux-x86_64/bin'

############################# ASDF (Global package manager)
add_path_if_exist "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"

############################## Go
add_path_if_exist '/usr/local/go/bin'
add_path_if_exist "$HOME/go/bin"
