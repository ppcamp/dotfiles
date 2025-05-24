# vim: ts=4 sts=4 sw=4 noet

install-asdf: ## Install asdf for the system
	curl -sLo - https://github.com/asdf-vm/asdf/releases/download/v0.16.5/asdf-v0.16.5-linux-amd64.tar.gz | sudo tar -xzC /usr/bin

uninstall-asdf: ## Uninstall asdf
	sudo rm /usr/bin/asdf
