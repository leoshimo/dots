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

.PHONY: pkgs_macos_all
pkgs_macos_all: pkgs_macos_core pkgs_macos_apps

$(BREW_BIN):
	[ -f $(BREW_BIN) ] || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: pkgs_macos_core
pkgs_macos_core: $(BREW_BIN)
	$(BREW_BIN) bundle --file=homebrew/Brewfile-core

.PHONY: pkgs_macos_apps
pkgs_macos_apps: $(BREW_BIN)
	$(BREW_BIN) bundle --file=homebrew/Brewfile-apps
