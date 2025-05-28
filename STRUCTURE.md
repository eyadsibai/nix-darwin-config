# Nix Darwin Configuration Structure

This repository has been reorganized to merge home-manager configurations with darwin system configurations for better organization and maintainability.

## Directory Structure

```
.
├── darwin/                 # All system and user configurations
│   ├── nix-core.nix       # Core Nix configuration
│   ├── system.nix         # macOS system settings
│   ├── host-users.nix     # User account configuration
│   ├── apps.nix           # Applications (system packages + homebrew)
│   ├── shell.nix          # Shell configurations (zsh, nushell, starship)
│   ├── dev-tools.nix      # Development tools (git, helix, eza, etc.)
│   ├── nixvim.nix         # Neovim configuration via nixvim
│   └── home.nix           # Base home-manager configuration
├── configs/               # Static configuration files
│   ├── aerospace.toml     # Aerospace window manager config
│   ├── bordersrc          # Borders configuration
│   └── sketchybar/        # Sketchybar configuration files
└── flake.nix             # Main flake configuration

```

## Configuration Pattern

Each module in the `darwin/` directory follows a consistent pattern where:
- System-level configurations are defined at the top level
- Home-manager configurations are nested under `home-manager.users.${username}`

Example from `shell.nix`:
```nix
{
  # System-level configuration
  programs.zsh.enable = true;
  
  # Home-manager configuration
  home-manager.users.${username} = {
    programs.zsh = { ... };
    programs.starship = { ... };
  };
}
```

## Key Changes from Previous Structure

1. **Eliminated separate `home/` directory** - All configurations are now in `darwin/`
2. **Merged related configurations** - For example, shell and starship configs are now in one file
3. **Static config files moved to `configs/`** - Makes it clear which files are Nix modules vs static configs
4. **Consistent naming** - All modules follow the pattern of grouping related functionality

## Module Breakdown

- **apps.nix**: System packages, Homebrew formulas/casks, and basic home-manager app configs
- **shell.nix**: Shell environments (zsh, nushell) and prompt (starship)
- **dev-tools.nix**: Development tools including git, editors (helix), and CLI utilities
- **nixvim.nix**: Complete Neovim configuration using nixvim
- **home.nix**: Base home-manager setup and static file deployments
