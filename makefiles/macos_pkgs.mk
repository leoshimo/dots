# Makefile - MacOS Packages (Homebrew)

ARCH := $(shell uname -p)
ifeq ($(ARCH),i386)
	BREW_BIN := /usr/local/bin/brew
endif
ifeq ($(ARCH),arm)
	BREW_BIN := /opt/homebrew/bin/brew
endif

.PHONY: pkgs_all
pkgs_all: install_brew pkgs_core ## Install all packages

.PHONY: install_brew
install_brew:
	# Install brew if needed
	[ -f $(BREW_BIN) ] || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: pkgs_core
pkgs_core: ## Install core packages
	$(BREW_BIN) bundle --file=homebrew/Brewfile-core
