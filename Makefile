# Flutter Neobrutalist Resume Makefile Harness
# AI Native SDLC Compliant Command Interface

FLUTTER ?= $(shell which flutter 2>/dev/null || echo "/Users/jbavaji/Documents/development/sdks/flutter/bin/flutter")
DART ?= $(shell which dart 2>/dev/null || echo "/Users/jbavaji/Documents/development/sdks/flutter/bin/dart")

.PHONY: help init check-env lint test build fix run clean token-audit

help: ## Show available commands
	@echo "AI-SDLC Command Interface (Flutter / Dart):"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

init: ## Synchronize AI agent memory bank across Antigravity, Claude, Copilot, Cursor
	@./.agent/sync-agent-config.sh

token-audit: ## Scan project files for raw visual CSS / design token violations
	@./.agent/security/token-audit.sh .

check-env: ## Verify Flutter and Dart SDK availability
	@echo "Checking Flutter & Dart SDK environment..."
	@$(FLUTTER) --version || (echo "Flutter SDK not found." && exit 1)
	@echo "✓ Flutter SDK verified"

lint: ## Run static analysis and format check
	@echo "Checking Dart formatting..."
	@$(DART) format --output=none --set-exit-if-changed .
	@echo "Running dart analyze..."
	@$(FLUTTER) analyze
	@echo "✓ Static analysis and formatting passed"

test: ## Run unit and widget test suite
	@echo "Running flutter test..."
	@$(FLUTTER) test
	@echo "✓ All tests passed"

build: ## Build optimized production bundle for Flutter Web
	@echo "Building Flutter Web release bundle..."
	@$(FLUTTER) build web --release --base-href "/"
	@echo "✓ Web build complete in build/web/"

fix: ## Automatically format and fix mechanical issues
	@echo "Formatting Dart code..."
	@$(DART) format .
	@echo "Applying dart fix..."
	@$(DART) fix --apply
	@echo "✓ Formatting and fixes complete"

run: ## Run local development server in Chrome
	@$(FLUTTER) run -d chrome --web-port=8090

clean: ## Clean Flutter build artifacts
	@echo "Cleaning Flutter project..."
	@$(FLUTTER) clean
