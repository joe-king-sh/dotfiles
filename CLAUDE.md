# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository using **Nix** and **Home Manager** for declarative system configuration on macOS (Apple Silicon). The configuration is modular and uses nix-darwin for system-level settings.

## Common Development Commands

### Deployment

- `make switch` - Deploy system configuration (nix-darwin)
- `make switch-home` - Deploy user configuration (home-manager)

### Development & Testing

- `make build` - Run nix flake check to verify configuration
- `make dry-run` - Test builds without applying changes
- `make fmt` - Format all Nix code using treefmt
- `make check-fmt` - Check if formatting is needed

### Maintenance

- `make update` - Update all flake dependencies
- `make clean` - Clean up old system generations
- `make debug` - Show system info and flake details

### Security

- `make scan-secrets` - Scan all files for sensitive information using detect-secrets

## Architecture & Key Files

### Core Configuration

- `flake.nix` - Main entry point defining system architecture, user mapping, and configurations
- `nix-darwin/default.nix` - macOS system settings, Homebrew packages, and system preferences
- `home-manager/home.nix` - User packages and imports individual program configs
- `home-manager/programs/` - Individual program configurations (zsh, git, vscode, etc.)

### Program Configuration Pattern

Each program in `home-manager/programs/` follows this structure:

```nix
{ pkgs, ... }: {
  programs.PROGRAM_NAME = {
    enable = true;
    # Program-specific settings
  };
}
```

### Adding New Tools

1. **System-wide tools** (GUI apps, casks): Add to `nix-darwin/default.nix` under `homebrew.casks`
2. **User CLI tools**: Add to `home-manager/home.nix` under `home.packages`
3. **Configured programs**: Create new file in `home-manager/programs/` and import in `home.nix`

## CI/CD

GitHub Actions runs on all PRs to main branch:

1. Installs Nix with flakes
2. Sets up Cachix for build caching
3. Runs `make build`, `make check-fmt`, and `make dry-run`

## Important Notes

- Always run `make fmt` before committing Nix changes
- Use `make dry-run` to test configuration changes safely
- The repository uses renovate for automated dependency updates
- Pre-commit hooks are configured - run `make setup-security` once after cloning
