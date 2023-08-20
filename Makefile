# Makefile for Repository

# Platform-Specific
OS := $(shell uname -s)
ifeq ($(OS),Linux)
	# TODO
endif
ifeq ($(OS),Darwin)
	include makefiles/macos_*.mk
	SETUP = prefs
endif

help:	## Show Help
	@grep --no-filename -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: $(SETUP) ## Run full setup
