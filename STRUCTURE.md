# Nix Darwin Configuration Structure

## Current File Organization

### Core System Files
- `flake.nix` - Main flake configuration
- `darwin/nix-core.nix` - Core Nix settings (flakes, garbage collection, optimization)
- `darwin/system.nix` - macOS system settings (dock, finder, keyboard, fonts)
- `darwin/host-users.nix` - User and hostname configuration

### Application and Tool Files
- `darwin/apps.nix` - GUI applications, browsers, media tools, and Homebrew configuration
- `darwin/dev-tools.nix` - Development tools, language servers, Git, and code editors
- `darwin/shell.nix` - Shell configurations (zsh, nushell, starship)
- `darwin/nixvim.nix` - Neovim configuration (currently disabled in flake.nix)
- `darwin/configs.nix` - Configuration file mappings

## File Organization Summary

The current file naming is kept as-is for consistency:
- `apps.nix` - Contains all applications and Homebrew configuration
- `configs.nix` - Contains configuration file mappings
- `nix-core.nix` - Core Nix settings
- `system.nix` - macOS system settings

### Content Organization
The current organization is mostly good, with clear separation between:
- System-level settings vs user-level settings
- Applications vs development tools
- Shell configuration separate from other tools

### Notes
- The helix editor configuration has been moved from apps.nix to dev-tools.nix where it belongs
- All development-related programs are now consolidated in dev-tools.nix
- GUI applications and general utilities are in apps.nix
- Shell-specific configurations remain in shell.nix
