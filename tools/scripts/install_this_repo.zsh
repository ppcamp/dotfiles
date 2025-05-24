#!/bin/zsh

# RUN THIS SCRIPT BY DOING
#
#
# curl -sL https://raw.githubusercontent.com/ppcamp/shell/refs/heads/main/tools/scripts/install_this_repo.zsh | zsh -
# curl -sL https://raw.githubusercontent.com/ppcamp/shell/refs/heads/main/tools/scripts/install_this_repo.zsh | INSTALL_DIR=$HOME/.config/shell zsh -

INSTALL_DIR=${INSTALL_DIR:-$HOME/.config/shell}
echo "Installing it at $INSTALL_DIR"

ZSHRC_INIT_FILE=${INSTALL_DIR}/init.zsh

git clone --recursive https://github.com/ppcamp/shell ${INSTALL_DIR}
echo "Installed shell at $INSTALL_DIR"

echo "Setup zshrc"
echo "source $ZSHRC_INIT_FILE" >>$HOME/.zshrc

echo "Installing xcp/xpb scripts (required)"
pushd $(pwd) >/dev/null
cd $INSTALL_DIR
make install-xcp
popd >/dev/null
