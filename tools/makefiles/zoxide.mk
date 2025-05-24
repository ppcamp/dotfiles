# vim: ts=4 sts=4 sw=4 noet

install-zoxide: ## Install zoxide (cd improved)
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

configure-zoxide: ## Configure zoxide
	@echo "To configure properly, check the plugins for zoxide installed in this repo."
	@echo "When running outside, need to eval (see below)"
	@echo 'eval "$(zoxide init zsh)"' >> $ZSH_CUSTOM/programs.zsh
