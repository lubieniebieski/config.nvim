# Dotfiles Makefile for GNU Stow
# Usage:
#   make install          - Install all packages
#   make install PACKAGE=nvim - Install specific package
#   make uninstall        - Uninstall all packages
#   make uninstall PACKAGE=nvim - Uninstall specific package
#   make list             - List available packages
#   make check            - Check if stow is installed

# Configuration
STOW_DIR := $(shell pwd)
TARGET_DIR := $(HOME)
STOW := stow

# Find all directories that could be packages (excluding hidden directories and common non-package dirs)
PACKAGES := $(shell find . -maxdepth 1 -type d ! -name '.*' ! -name 'Makefile*' ! -name 'README*' ! -name 'LICENSE*' ! -name 'docs' -exec basename {} \;)

# Default target
.DEFAULT_GOAL := help

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m # No Color

.PHONY: help check install uninstall install-all uninstall-all list clean restow

help: ## Show this help message
	@echo "$(GREEN)Dotfiles Management with GNU Stow$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make install                Install all packages"
	@echo "  make install pkg1 pkg2      Install specific packages"
	@echo "  make uninstall              Uninstall all packages"
	@echo "  make uninstall pkg1 pkg2    Uninstall specific packages"
	@echo "  make list                   List available packages"
	@echo "  make check                  Check if stow is installed"
	@echo "  make clean                  Remove broken symlinks"
	@echo ""
	@echo "$(YELLOW)Available packages:$(NC)"
	@for pkg in $(PACKAGES); do echo "  - $$pkg"; done

check: ## Check if GNU Stow is installed
	@command -v $(STOW) >/dev/null 2>&1 || { \
		echo "$(RED)Error: GNU Stow is not installed$(NC)"; \
		echo "Install it with: brew install stow"; \
		exit 1; \
	}
	@echo "$(GREEN)GNU Stow is installed$(NC)"

list: ## List available packages
	@echo "$(YELLOW)Available packages:$(NC)"
	@for pkg in $(PACKAGES); do echo "  - $$pkg"; done

install: check ## Install packages (all if no args, or specific packages: make install nvim tmux)
	@if [ "$(MAKECMDGOALS)" = "install" ] && [ -z "$(filter-out install,$(MAKECMDGOALS))" ]; then \
		echo "$(GREEN)Installing all packages...$(NC)"; \
		for pkg in $(PACKAGES); do \
			echo "$(GREEN)Installing: $$pkg$(NC)"; \
			$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --verbose $$pkg; \
		done; \
		echo "$(GREEN)All packages installed successfully!$(NC)"; \
	else \
		target_packages="$(filter-out install,$(MAKECMDGOALS))"; \
		if [ -n "$$target_packages" ]; then \
			echo "$(GREEN)Installing specified packages: $$target_packages$(NC)"; \
			for pkg in $$target_packages; do \
				if [ -d "$$pkg" ]; then \
					echo "$(GREEN)Installing: $$pkg$(NC)"; \
					$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --verbose $$pkg; \
				else \
					echo "$(RED)Error: Package '$$pkg' not found$(NC)"; \
					echo "Available packages: $(PACKAGES)"; \
					exit 1; \
				fi; \
			done; \
			echo "$(GREEN)Specified packages installed successfully!$(NC)"; \
		fi; \
	fi

# Dummy targets for package names to prevent "No rule to make target" errors
%:
	@:

uninstall: check ## Uninstall packages (all if no args, or specific packages: make uninstall nvim tmux)
	@if [ "$(MAKECMDGOALS)" = "uninstall" ] && [ -z "$(filter-out uninstall,$(MAKECMDGOALS))" ]; then \
		echo "$(YELLOW)Uninstalling all packages...$(NC)"; \
		for pkg in $(PACKAGES); do \
			echo "$(YELLOW)Uninstalling: $$pkg$(NC)"; \
			$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --delete --verbose $$pkg 2>/dev/null || true; \
		done; \
		echo "$(GREEN)All packages uninstalled successfully!$(NC)"; \
	else \
		target_packages="$(filter-out uninstall,$(MAKECMDGOALS))"; \
		if [ -n "$$target_packages" ]; then \
			echo "$(YELLOW)Uninstalling specified packages: $$target_packages$(NC)"; \
			for pkg in $$target_packages; do \
				if [ -d "$$pkg" ]; then \
					echo "$(YELLOW)Uninstalling: $$pkg$(NC)"; \
					$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --delete --verbose $$pkg; \
				else \
					echo "$(RED)Error: Package '$$pkg' not found$(NC)"; \
					echo "Available packages: $(PACKAGES)"; \
					exit 1; \
				fi; \
			done; \
			echo "$(GREEN)Specified packages uninstalled successfully!$(NC)"; \
		fi; \
	fi

# Aliases for convenience
install-all: install ## Alias for 'make install'

uninstall-all: uninstall ## Alias for 'make uninstall'

clean: ## Remove broken symlinks in home directory
	@echo "$(YELLOW)Cleaning broken symlinks in $(TARGET_DIR)...$(NC)"
	@find $(TARGET_DIR) -maxdepth 3 -type l -exec test ! -e {} \; -print -delete 2>/dev/null || true
	@echo "$(GREEN)Cleanup completed$(NC)"

# Development helpers
restow: check ## Restow all packages (useful after adding new files)
ifdef PACKAGES
	@echo "$(GREEN)Restowing specified packages: $(PACKAGES)$(NC)"
	@for pkg in $(PACKAGES); do \
		if [ -d "$$pkg" ]; then \
			echo "$(GREEN)Restowing: $$pkg$(NC)"; \
			$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --restow --verbose $$pkg; \
		else \
			echo "$(RED)Error: Package '$$pkg' not found$(NC)"; \
			exit 1; \
		fi; \
	done
else ifdef PACKAGE
	@echo "$(GREEN)Restowing package: $(PACKAGE)$(NC)"
	@$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --restow --verbose $(PACKAGE)
else
	@echo "$(GREEN)Restowing all packages...$(NC)"
	@for pkg in $(PACKAGES); do \
		echo "$(GREEN)Restowing: $$pkg$(NC)"; \
		$(STOW) --dir=$(STOW_DIR) --target=$(TARGET_DIR) --restow --verbose $$pkg; \
	done
endif
