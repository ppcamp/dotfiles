# vim: ts=4 sts=4 sw=4 noet


install-nvim:
	@echo "Installing nvim..."
	# Download and install nvim
	sudo rm -rf /opt/nvim
	curl -sL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz  | sudo tar -xz -C /opt
