# homebrew - GNU Stow

OS := $(shell uname -s)

.PHONY: link
link: ## Setup symlinks
ifeq (, $(shell which stow))
	$(error "No stow in $$PATH")
endif

	# Shared
	stow stow

ifeq ($(OS),Darwin)
	# TODO
endif
