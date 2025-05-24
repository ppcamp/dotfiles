# vim: ts=4 sts=4 sw=4 noet

install-eza: ## Install eza (ls improved)
	curl -Lo - https://github.com/eza-community/eza/releases/download/v0.20.24/eza_x86_64-unknown-linux-musl.tar.gz | \
		tar -xzC $HOME/.local/bin # --transform='s|eza|ls|'

configure-eza: ## Configure eza (when running outside this repo)
	echo 'alias ls="eza --color=auto --git --icons"' >> $ZSH_CUSTOM/aliases.zsh
