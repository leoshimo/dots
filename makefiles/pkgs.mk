# Packages

.PHONY: pkgs_all
pkgs_all:						## Install all packages
	$(MAKE) pkgs_core
	$(MAKE) pkgs_apps
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_macos_all
endif

.PHONY: pkgs_core
pkgs_core: 						## Install core packages
	$(MAKE) pkgs_antidote
	$(MAKE) pkgs_powerline_fonts
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_macos_core
endif

.PHONY: pkgs_apps
pkgs_apps: 						## Install app packages
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_macos_apps
endif

# Antidote - https://github.com/mattmc3/antidote
ANTIDOTE := $(HOME)/.antidote
.PHONY: pkgs_antidote
pkgs_antidote: $(ANTIDOTE)
$(ANTIDOTE):
	git clone --depth=1 https://github.com/mattmc3/antidote.git $(HOME)/.antidote

# Powerline Fonts - https://github.com/powerline/fonts
POWERLINE_FONTS := $(HOME)/.config/powerline-fonts
.PHONY: pkgs_powerline_fonts
pkgs_powerline_fonts: $(POWERLINE_FONTS)
$(POWERLINE_FONTS):
	mkdir -p $(POWERLINE_FONTS)
	git clone https://github.com/powerline/fonts.git --depth=1 $(POWERLINE_FONTS)
	$(POWERLINE_FONTS)/install.sh

# Rust
.PHONY: pkgs_rust
pkgs_rust:		## Install packages for Rust Development
	# Rustup - https://rustup.rs
	command -v rustup >/dev/null || \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rust-analyzer
	cargo install cargo-edit # for cargo upgrade

# Janet
.PHONY: pkgs_janet
pkgs_janet:		## Install Janet Lang
ifeq ($(OS),Darwin)
	brew install janet
else
	@echo "Error: Unsupported platform for pkgs_janet" && exit 1
endif

# Elixir
.PHONY: pkgs_elixir
pkgs_elixir:	## Install Elixir
ifeq ($(OS),Darwin)
	brew install elixir
else
	@echo "Error: Unsupported platform for pkgs_janet" && exit 1
endif
