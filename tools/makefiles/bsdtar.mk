# vim: ts=4 sts=4 sw=4 noet


install-bsdtar: ## Add bsdtar (tar improved with zip)
	sudo apt install -y libarchive-tools

uninstall-bsdtar: ## Remove bsdtar
	sudo apt autoremove -y libarchive-tools
