# vim: ts=4 sts=4 sw=4 noet

# TODO: replace this by prettier or something like that
install-shfmt: ## Install shfmt (formatter for zsh)
	go install mvdan.cc/sh/v3/cmd/shfmt@latest
