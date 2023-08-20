# Makefile - MacOS Packages (Homebrew)

BREW_BIN := /usr/local/bin/brew

.PHONY: pkgs_all
pkgs_all: install_brew ## Install all pkgs

.PHONY: install_brew
install_brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

