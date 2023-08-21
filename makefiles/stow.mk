# homebrew - GNU Stow

OS := $(shell uname -s)
ARCH := $(shell uname -p)

ifeq ($(OS),Darwin)
ifeq ($(ARCH),i386)
	STOW_BIN := /usr/local/bin/stow
endif
ifeq ($(ARCH),arm)
	STOW_BIN := /opt/homebrew/bin/stow
endif
endif

.PHONY: link
link: ## Setup symlinks
	# Shared
	$(STOW_BIN) stow
	$(STOW_BIN) zsh
	$(STOW_BIN) tmux
	$(STOW_BIN) emacs
	$(STOW_BIN) alacritty
	$(STOW_BIN) git
	$(STOW_BIN) starship
	$(STOW_BIN) raycast

ifeq ($(OS),Darwin)
	$(STOW_BIN) hammerspoon
	$(STOW_BIN) launchagents
endif
