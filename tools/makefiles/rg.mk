# vim: ts=4 sts=4 sw=4 noet

install-rg: ## Install rg and set as default
	curl -sLo - https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz | tar -xzC /tmp
	sudo mv /tmp/ripgrep-14.1.1-x86_64-unknown-linux-musl/rg /usr/bin 
	rm -rfd /tmp/ripgrep-14.1.1-x86_64-unknown-linux-musl

uninstall-rg: ## Uninstall rg
	sudo rm /usr/bin/rg

