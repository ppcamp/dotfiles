default: help

REGEX_COLUMN_SEP = :
REGEX_MAKEFILE_DOC = ^([a-zA-Z_-]+):.* \#\# (.*)$$
REGEX_MD_ITALIC = \*{1}([a-zA-Z0-9=\_\ \-]+)\*{1}
REGEX_MD_BOLD = \*{2}([a-zA-Z0-9=\_\ \-]+)\*{2}
REGEX_MD_MONO = `([a-zA-Z0-9=\_\ \-]+)`
REGEX_MD_LINK = \[([a-zA-Z0-9=\_\ \-]+)\]
REGEX_MD_UNDERLINE = \_{1}([a-zA-Z0-9=\_\ \-]+)\_{1}

# Colors
LD = ${ESC}[0m#   default
FF = ${ESC}[2m#   faint
FI = ${ESC}[3m#   italic

# Inner vars
SHELL := /bin/bash
ESC = \x1b

.PHONY: run
.PHONY: help

install_shfmt: ## Install shfmt formatter for bash/zsh scripts
	@echo "Installing shfmt..."
	@go install mvdan.cc/sh/v3/cmd/shfmt@latest
	@echo "shfmt installed successfully."

install_gotools: ## Install go required deps
	@echo "Installing"
	@echo "Open nvim and Run :GoInstallBinaries"


help:
	@printf "$(FF) Available methods: $(LD)\n\n"
    # 1. read makefile
    # 2. get lines that can have a method description
    # 3. color method names and add a COLUMN_SEPARATOR
    # 4. colour backticks (``)
    # 5. colour brackets ([])
    # 6. make it bold
    # 7. make it italic
    # 8. make it underline
    # 9. show as table
	@cat $(MAKEFILE_LIST) | \
	 	grep -E "$(REGEX_MAKEFILE_DOC)" | \
		sed -En 's/$(REGEX_MAKEFILE_DOC)/$(F2)\1$(REGEX_COLUMN_SEP)$(LD)\2/p' | \
		sed -En 's/$(REGEX_MD_MONO)/$(F3)\1$(LD)/g;p' | \
		sed -En 's/$(REGEX_MD_LINK)/$(F6)\1$(LD)/g;p' | \
		sed -En 's/$(REGEX_MD_BOLD)/$(LB)\1$(LD)/g;p' | \
		sed -En 's/$(REGEX_MD_ITALIC)/$(FI)\1$(LD)/g;p' | \
		sed -En 's/$(REGEX_MD_UNDERLINE)/$(FU)\1$(LD)/g;p' | \
		column -t -s "$(REGEX_COLUMN_SEP)"
