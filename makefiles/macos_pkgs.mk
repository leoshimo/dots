# Makefile - MacOS Packages (Homebrew)

ARCH := $(shell uname -p)
ifeq ($(ARCH),i386)
	BREW_BIN := /usr/local/bin/brew
	MAS_BIN := /usr/local/bin/mas
endif
ifeq ($(ARCH),arm)
	BREW_BIN := /opt/homebrew/bin/brew
	MAS_BIN := /opt/homebrew/bin/mas
endif

.PHONY: pkgs_all
pkgs_all: install_brew pkgs_core pkgs_apps ## Install all packages

.PHONY: install_brew
install_brew:
	# Install brew if needed
	[ -f $(BREW_BIN) ] || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: pkgs_core
pkgs_core: ## Install core packages
	$(BREW_BIN) bundle --file=homebrew/Brewfile-core

.PHONY: pkgs_apps
pkgs_apps: $(BREW_BIN)	## Install app packages
	@($(MAS_BIN) account | grep --quiet "Not signed in") && \
		(echo "Error: Not signed into App Store"; open -a "App Store") || \
	 	$(BREW_BIN) bundle --file=homebrew/Brewfile-apps
