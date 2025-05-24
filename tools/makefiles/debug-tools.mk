# vim: ts=4 sts=4 sw=4 noet

install-debug-tools: ## Install usefull debugging tools for debian
	sudo apt update
	sudo apt install g++ make cmake gcc
	sudo apt install binutils gdb strace lsof file
	# binutils   includes objdump, readelf, nm, etc.
	# gdb        for debugging.
	# strace     for system calls.
	# lsof       for open file descriptors.
	# file       inspeact the type of the file
