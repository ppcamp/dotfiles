# vim: ts=4 sts=4 sw=4 noet

install-starship: ## Install starship (prompt)
	curl -sS https://starship.rs/install.sh | sh

configure-startship: ## Configure starship (when running outside this repo)
	echo "Adding starship to zsh"
	echo $'cat \'eval "$(starship init zsh)"\' >>  $HOME/.zshrc'
	echo 'Check cat <<EOF > $HOME/.config/starship.toml'
