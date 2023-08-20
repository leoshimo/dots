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
pkgs_all: pkgs_core pkgs_apps ## Install all packages

$(BREW_BIN):
	[ -f $(BREW_BIN) ] || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: pkgs_core
pkgs_core: $(BREW_BIN) ## Install core packages
	$(BREW_BIN) bundle --file=homebrew/Brewfile-core

.PHONY: pkgs_apps
pkgs_apps: $(BREW_BIN)	## Install app packages
	$(BREW_BIN) bundle --file=homebrew/Brewfile-apps
