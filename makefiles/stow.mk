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

ifeq ($(OS),Darwin)
	# TODO
endif
