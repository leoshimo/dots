# Packages

BREW := $(shell which brew)
BREW_PREFIX := $(shell brew --prefix)

.PHONY: pkgs_all
pkgs_all:						## Install CLI and GUI packages
	$(MAKE) pkgs_cli
	$(MAKE) pkgs_gui

.PHONY: pkgs_cli
pkgs_cli: 						## Install CLI packages
ifeq ($(OS),Darwin)
	$(BREW) bundle --file=homebrew/Brewfile-CLI

	# fzf - post-install
	[ -f $(HOME)/.fzf.zsh ] || ($(BREW_PREFIX)/opt/fzf/install; rm ~/.fzf.bash)
endif

.PHONY: pkgs_gui
pkgs_gui: 						## Install GUI packages
ifeq ($(OS),Darwin)
	$(BREW) bundle --file=homebrew/Brewfile-GUI
endif

.PHONY: pkgs_rust
pkgs_rust:						## Install Rust toolchain
	# Rustup - https://rustup.rs
	command -v rustup >/dev/null || \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rust-analyzer
	cargo install cargo-edit  # for cargo upgrade
	cargo install cargo-release
	cargo install cargo-audit
	cargo install cargo-watch
