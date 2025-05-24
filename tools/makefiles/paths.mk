# vim: ts=4 sts=4 sw=4 et

# add paths if not empty
define IMPORT_IFD
	@if [ -n "$(1)" ]; then \
		echo "export PATH=\"\$$PATH:$(1)\"" >> ~/.zshrc; \
	fi
endef

#source if exist
define IMPORT_IF
	@if [ -d "$(1)" ]; then \
		echo "source $(1)" >> ~/.zshrc; \
	fi
endef

configure-paths: ## Run pre defined commands to add new paths to environment basing on installed tools
	@echo "Configuring paths..."

	@echo "  - Adding golang paths"
	$(call IMPORT_IFD,$(shell go env GOPATH | xargs -I{} realpath "{}/bin"))

	@echo "  - Adding rust paths"
	$(call IMPORT_IFD,$(shell rustc --print sysroot | xargs -I{} realpath "{}/../../bin"))

	@echo "  - Adding nodejs paths"
	$(call IMPORT_IFD,$(shell npm config get prefix)/bin)	

	@echo "  - Adding python venv path"
	$(call IMPORT_IF,"$HOME/.cache/venv/bin/activate")
