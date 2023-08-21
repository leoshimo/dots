# Makefile for Repository

OS := $(shell uname -s)

include makefiles/pkgs.mk
include makefiles/stow.mk

ifeq ($(OS),Darwin)
	include makefiles/*macos*.mk
endif
ifeq ($(OS),Linux)
	include makefiles/*linux*.mk
endif

help:	## Show Help
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Run full setup
	$(MAKE) pkgs_all
	$(MAKE) link

ifeq ($(OS),Darwin)
	$(MAKE) prefs
endif

