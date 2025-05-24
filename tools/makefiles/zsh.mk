# vim: ts=4 sts=4 sw=4 noet

install-zsh: ## Install zsh and set as default
	sudo apt install zsh
	chsh -s $(which zsh)
