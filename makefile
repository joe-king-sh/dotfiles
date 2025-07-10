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

dry-run:
	nix build .#homeConfigurations.joe-king-sh.activationPackage --dry-run

.PHONY: all switch switch-home build fmt update clean debug dry-run