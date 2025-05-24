# vim: ts=4 sts=4 sw=4 noet

install-gh: ## Install github cli
	local file=gh_2.69.deb
	pushd $(pwd)
	cd /tmp
	curl -Lo $file https://github.com/cli/cli/releases/download/v2.69.0/gh_2.69.0_linux_amd64.deb
	sudo apt install "./$file"
	popd

configure-gh: ## Configure github cli
	gh auth login

install-gh-copilot: ## Install copilot extension for copilot cli
	gh extension install github/gh-copilot

configure-gh-copilot: ## Configure copilot extension for copilot cli
	gh copilot auth login
	@echo "When running outside, need to eval: " "gh copilot alias zsh > $ZSH_CUSTOM/copilot.zsh"
