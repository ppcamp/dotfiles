# vim: ts=4 sts=4 sw=4 noet

default: help

.PHONY: run
.PHONY: help
# Inner vars
SHELL := /bin/bash
ESC = \x1b

REGEX_COLUMN_SEP = :
REGEX_MAKEFILE_DOC = ^([a-zA-Z_-]+):.* \#\# (.*)$$

# fonts
LD = ${ESC}[0m#   default
FF = ${ESC}[2m#   faint
F2 = ${ESC}[32m#  green

include tools/makefiles/*.mk

install-required: asdf-install carapace-install fd-install fzf-install \
	rg-install starship-install 

install-recommended: install-required zoxide-install eza-install \
		gh-install \
		shfmt-install \
		tmux-install \
		zsh-install

help:
	@printf "$(FF)Available methods: $(LD)\n\n"
	@cat $(MAKEFILE_LIST) | \
	 	grep -E "$(REGEX_MAKEFILE_DOC)" | \
		sort -k 1 | \
		sed -En 's/$(REGEX_MAKEFILE_DOC)/$(F2)\1$(REGEX_COLUMN_SEP)$(LD)\2/p' | \
		column -t -s "$(REGEX_COLUMN_SEP)"
