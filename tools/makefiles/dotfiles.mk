# vim: ts=4 sts=4 sw=4 noet

ZSHRC_INIT_FILE=$(shell pwd)/init.zsh
GIT_GIST_FILES=https://gist.githubusercontent.com/ppcamp/a5d7828f3430226b2668b2f29bc38485/raw
KITTY_GIST_FILE=https://gist.githubusercontent.com/ppcamp/d841b729fd54cc23ad80f108310a65d0/raw

setup-fd: ## Setup fd link
	ln -fs ${ZEN}/dotfiles/fdignore ~/.fdignore

setup-starship: ## Crealte starship dotfile link
	ln -fs ${ZEN}/dotfiles/starship.toml ~/.config/starship.toml

setup-git: ## Create gitconfig link
	@echo "Create gitconfig link"
	curl -Ls $(GIT_GIST_FILES)/.gitconfig >> ~/.gitconfig

	@echo "Create git config template"
	curl -Ls $(GIT_GIST_FILES)/.git-template > ~/.git-template

setup-kitty: ## Update kitty conf
	@echo "Update kitty conf"
	curl -Ls $(KITTY_GIST_FILE)/kitty.conf > ~/.config/kitty/kitty.conf


setup-terminal: ## Update terminal choice (default terminal emulator)
	@echo "Change default terminal for gnome"
	sudo update-alternatives --config x-terminal-emulator

kitty-change-theme: ## Change kitty theme
	@echo "Change theme"
	kitty +kitten themes


setup-zshrc: ## Update .zshrc file with current configs
	@echo "source $(ZSHRC_INIT_FILE)">> ~/.zshrc

setup-wsl-xcp: ## Add wsl-xcp to .zshrc
	@echo "Add xcp alias to .zshrc"
	@printf '%s\n' \
		'alias xcp=clip.exe' \
		'alias xpb='\''powershell.exe -Command "Get-Clipboard"'\' >> ~/.zshrc
