# Packages

.PHONY: pkgs_all
pkgs_all:						## Install all packages
	$(MAKE) pkgs_core
	$(MAKE) pkgs_apps
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_all_macos
endif

.PHONY: pkgs_core
pkgs_core: 						## Install core packages
	$(MAKE) pkgs_antidote
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_core_macos
endif

.PHONY: pkgs_apps
pkgs_apps: 						## Install app packages
ifeq ($(OS),Darwin)
	$(MAKE) pkgs_apps_macos
endif

# Antidote - https://github.com/mattmc3/antidote
ANTIDOTE := $(HOME)/.antidote
.PHONY: pkgs_antidote
pkgs_antidote: $(ANTIDOTE)
$(ANTIDOTE):
	git clone --depth=1 https://github.com/mattmc3/antidote.git $(HOME)/.antidote
