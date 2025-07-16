all: switch

switch:
	sudo nix run github:LnL7/nix-darwin --extra-experimental-features 'flakes nix-command' -- switch --flake ".#joe-king-sh"
	# After initial setup: sudo nix run github:LnL7/nix-darwin -- switch --flake ".#joe-king-sh"

switch-home:
	nix run github:nix-community/home-manager --extra-experimental-features 'flakes nix-command' -- switch --flake ".#joe-king-sh"
	# After initial setup: nix run github:nix-community/home-manager -- switch --flake ".#joe-king-sh"

build:
	nix flake check

fmt:
	nix fmt

update:
	nix flake update

clean:
	nix-collect-garbage -d

debug:
	@echo "=== System Info ==="
	@echo "User: $$USER"
	@echo "OS: $$(uname -a)"
	@echo "Nix version: $$(nix --version 2>/dev/null || echo 'Nix not installed')"
	@echo ""
	@echo "=== Flake Check ==="
	nix flake check --no-build
	@echo ""
	@echo "=== Flake Show ==="
	nix flake show

check-fmt:
	@echo "Checking if files need formatting..."
	@nix fmt
	@if ! git diff --quiet; then \
		echo "ERROR: Files need formatting. Please run 'make fmt' and commit the changes."; \
		git diff; \
		exit 1; \
	else \
		echo "All files are properly formatted."; \
	fi

dry-run:
	nix build .#darwinConfigurations.joe-king-sh.system --dry-run
	nix build .#homeConfigurations.joe-king-sh.activationPackage --dry-run

# Security setup (one-time)
setup-security:
	@echo "Setting up security tools..."
	pre-commit install
	@echo "Creating detect-secrets baseline..."
	detect-secrets scan --disable-filter detect_secrets.filters.gibberish.should_exclude_secret . > .secrets.baseline
	@echo "Security setup completed!"

scan-secrets:
	pre-commit run detect-secrets --all-files

.PHONY: all switch switch-home build fmt update clean debug check-fmt dry-run setup-security scan-secrets