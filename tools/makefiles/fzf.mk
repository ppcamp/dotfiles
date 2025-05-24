# vim: ts=4 sts=4 sw=4 noet

install-fzf: ## Install fzf
	curl -sLo - "https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf-0.60.3-linux_amd64.tar.gz" | \
		sudo tar -xzC /usr/bin

configure-fzf: ## Configure fzf
	@echo "To configure properly, check the plugins for fzf installed in this repo."	

uninstall-fzf: ## Uninstall fzf
	sudo rm /usr/bin/fzf

# This needs to be installed as a shell script (binary),
# otherwise, it won't work for programs that try to call it
# directly (fzf execute opts, per example).
FZF_GIT_SHORTCUTS := /usr/bin/fzf-git

install-fzf-git: $(FZF_GIT_SHORTCUTS) ## FZF_GIT_SHORTCUTS install
	@echo "Installed xcp and xpb script files"

# run this if required by some recipe as a dependency (build file)
$(FZF_GIT_SHORTCUTS): tools/scripts/fzf-git
	@echo "Installing $@"
	chmod +x "$<"
	sudo cp "$<" /usr/bin
	@echo "Installed $@ at /usr/bin"

uninstall-fzf-git: ## Uninstall fzf-git
	sudo rm /usr/bin/fzf-git
