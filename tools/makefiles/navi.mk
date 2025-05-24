# vim: ts=4 sts=4 sw=4 noet

install-navi:
	# https://github.com/denisidoro/navi-tldr-pages/tree/master
	@echo "Installing navi..."
	curl -sLO https://github.com/denisidoro/navi/releases/download/v2.24.0/navi-v2.24.0-x86_64-unknown-linux-musl.tar.gz | \
		btar -xC /usr/local/bin
