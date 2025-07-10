# dotfiles

Personal development environment configuration using Nix and Home Manager.

## Prerequisites

Install package managers:

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Nix
sh <(curl -L https://nixos.org/nix/install)
nix --version
```

## Bootstrap

Deploy the configuration:

```bash
make switch
```

Or run directly:

```bash
sudo nix run github:LnL7/nix-darwin --extra-experimental-features 'flakes nix-command' -- switch --flake ".#joe-king-sh"
```

## Commands

- `make switch` - Deploy system configuration (nix-darwin)
- `make switch-home` - Deploy user configuration (home-manager)
- `make fmt` - Format code
- `make update` - Update flake dependencies
- `make clean` - Clean up old generations

## Known Issues

### Full Disk Access Required

If you encounter permission errors when running `make switch`:

```
error: could not set permissions on '/nix/var/nix/profiles/default' to 755: Operation not permitted
```

**Solution:**
1. System Preferences → Security & Privacy → Privacy
2. Select "Full Disk Access"
3. Add your terminal app (Terminal, iTerm2, Warp, etc.)
4. Restart terminal and retry

https://github.com/nix-darwin/nix-darwin/issues/1049

