# Makefile - MacOS Packages (Homebrew)

ARCH := $(shell uname -p)
ifeq ($(ARCH),i386)
	BREW_PREFIX := /usr/local/
	BREW_BIN := /usr/local/bin/brew
	MAS_BIN := /usr/local/bin/mas
endif
ifeq ($(ARCH),arm)
	BREW_PREFIX := /opt/homebrew
	BREW_BIN := /opt/homebrew/bin/brew
	MAS_BIN := /opt/homebrew/bin/mas
endif

.PHONY: pkgs_macos_all
pkgs_macos_all: pkgs_macos_core pkgs_macos_apps pkgs_fzf pkgs_skhd pkgs_yabai

$(BREW_BIN):
	[ -f $(BREW_BIN) ] || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: pkgs_macos_core
pkgs_macos_core: $(BREW_BIN)
	$(BREW_BIN) bundle --file=homebrew/Brewfile-core

.PHONY: pkgs_macos_apps
pkgs_macos_apps: $(BREW_BIN)
	$(BREW_BIN) bundle --file=homebrew/Brewfile-apps

.PHONY: pkgs_fzf
pkgs_fzf: $(BREW_BIN)
	# Brew-specific extra steps
	[ -f $(HOME)/.fzf.zsh ] || ($(BREW_PREFIX)/opt/fzf/install; rm ~/.fzf.bash)

.PHONY: pkgs_skhd
pkgs_skhd: $(BREW_BIN)
	# Install / Start skhd
	[ -f $(HOME)/Library/LaunchAgents/com.koekeishiya.skhd.plist ] || (skhd --install-service)
	pgrep -qx "skhd" || skhd --start-service

.PHONY: pkgs_yabai
pkgs_yabai: $(BREW_BIN)
	# Install / Start yabai
	[ -f $(HOME)/Library/LaunchAgents/com.koekeishiya.yabai.plist ] || (yabai --install-service)
	pgrep -qx "yabai" || yabai --start-service
