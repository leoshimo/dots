# Makefile for Repository

OS := $(shell uname -s)

include makefiles/stow.mk
ifeq ($(OS),Darwin)
	include makefiles/macos_*.mk
endif
ifeq ($(OS),Linux)
	include makefiles/linux_*.mk
endif

help:	## Show Help
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Run full setup
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_all
	$(MAKE) prefs
endif

	$(MAKE) link
