# vim: ts=2 sts=2 sw=2 et:

############################## PATH
# set PATH so it includes user's private bin if it exists
add_path_if_exist "$HOME/.local/bin"

############################# ASDF (Global package manager)
add_path_if_exist "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
