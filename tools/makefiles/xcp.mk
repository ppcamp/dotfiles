# vim: ts=4 sts=4 sw=4 noet

# This needs to be installed as a shell script (binary),
# otherwise, it won't work for programs that try to call it
# directly (fzf execute opts, per example).

THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
XCP_BIN_SCRIPT := /usr/bin/xcp
XPB_BIN_SCRIPT := /usr/bin/xpb

define build_template
	@echo "Installing $@"
	chmod +x "$<"
	sudo cp "$<" /usr/bin
	@echo "Installed $@ at /usr/bin"
endef


install-xcp: $(XCP_BIN_SCRIPT) $(XPB_BIN_SCRIPT) ## Xcp shortcut install
	@echo "Installed xcp and xpb script files"


# run this if required by some recipe as a dependency (build file)
$(XCP_BIN_SCRIPT): tools/scripts/xcp
	$(build_template)

$(XPB_BIN_SCRIPT): tools/scripts/xpb
	$(build_template)
