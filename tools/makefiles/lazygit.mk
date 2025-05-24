# vim: ts=4 sts=4 sw=4 noet

install-lazygit: ## Install lazygit
	curl -sLo - "https://github.com/jesseduffield/lazygit/releases/download/v0.50.0/lazygit_0.50.0_Linux_x86_64.tar.gz" | \
		sudo tar -xzC /usr/bin

configure-lazygit: ## Configure lazygit
	@echo "To configure properly, check the plugins for lazygit installed in this repo."	

uninstall-lazygit: ## Uninstall lazygit
	sudo rm /usr/bin/lazygit
