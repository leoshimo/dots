# homebrew - GNU Stow

STOW_BIN := $(shell which stow)

.PHONY: link
link: ## Setup symlinks
	$(STOW_BIN) stow
	$(STOW_BIN) zsh
	$(STOW_BIN) tmux
	$(STOW_BIN) vim
	$(STOW_BIN) emacs
	$(STOW_BIN) git
	$(STOW_BIN) starship
	$(STOW_BIN) ghostty
	$(STOW_BIN) gmailctl
	$(STOW_BIN) feedbinctl

ifeq ($(OS),Darwin)
	$(STOW_BIN) hammerspoon
	$(STOW_BIN) launchagents
endif
