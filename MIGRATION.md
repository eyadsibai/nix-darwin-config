# Migration Guide

This guide helps you migrate from the old nix-darwin configuration structure to the new organized layout.

## 🔄 What Changed

### Old Structure
```
.
├── flake.nix
├── darwin/
│   ├── apps.nix
│   ├── host-users.nix
│   ├── nix-core.nix
│   └── system.nix
└── home/
    ├── apps.nix
    ├── core.nix
    ├── default.nix
    ├── git.nix
    ├── nixvim.nix
    ├── shell.nix
    ├── starship.nix
    └── sketchybar/
```

### New Structure
```
.
├── flake.nix
├── hosts/
│   ├── common/
│   │   ├── darwin/
│   │   ├── packages/
│   │   ├── homebrew/
│   │   └── nix.nix
│   └── eyad-m3/
└── users/
    └── eyad/
        ├── programs/
        └── dotfiles/
```

## 📋 Migration Steps

### 1. Backup Your Current Configuration
```bash
cp -r ~/.config/nix-darwin ~/.config/nix-darwin-backup
```

### 2. File Mapping

| Old Location | New Location | Notes |
|--------------|--------------|-------|
| `darwin/system.nix` | `hosts/common/darwin/system.nix` | System settings |
| `darwin/nix-core.nix` | `hosts/common/nix.nix` | Nix configuration |
| `darwin/apps.nix` | `hosts/common/packages/` + `hosts/common/homebrew/` | Split by package type |
| `darwin/host-users.nix` | `hosts/eyad-m3/users.nix` | Host-specific users |
| `home/default.nix` | `users/eyad/default.nix` | User entry point |
| `home/shell.nix` | `users/eyad/programs/shell.nix` | Shell configuration |
| `home/git.nix` | `users/eyad/programs/git.nix` | Git configuration |
| `home/starship.nix` | `users/eyad/programs/starship.nix` | Starship prompt |
| `home/nixvim.nix` | `users/eyad/programs/nixvim.nix` | Neovim configuration |
| `home/apps.nix` | `users/eyad/programs/helix.nix` + `users/eyad/programs/cli-tools.nix` | Split by program type |
| `home/bordersrc` | `users/eyad/dotfiles/bordersrc` | Dotfiles |
| `home/sketchybar/` | `users/eyad/dotfiles/sketchybar/` | SketchyBar config |

### 3. Update Your Configuration

The new structure has already been created with your existing configuration. You can:

1. **Test the new configuration:**
   ```bash
   just check
   ```

2. **Build without switching:**
   ```bash
   nix build .#darwinConfigurations.eyad-m3.system
   ```

3. **Apply the new configuration:**
   ```bash
   just darwin
   ```

### 4. Clean Up Old Files (Optional)

After confirming everything works:
```bash
# Remove old directories
rm -rf darwin/
rm -rf home/
```

## 🔧 Key Improvements

### 1. Multi-Host Support
- Easy to add new machines
- Shared common configuration
- Host-specific customizations

### 2. Better Organization
- Packages grouped by category
- Clear separation of system vs user config
- Modular structure for easy maintenance

### 3. Enhanced Package Management
- Nix packages organized by purpose
- Homebrew configuration split into logical files
- Easy to enable/disable package groups

### 4. Improved User Management
- User-specific configurations
- Program configurations separated
- Dotfiles properly organized

## 🚨 Potential Issues

### 1. Missing Packages
If some packages are missing after migration:
- Check `hosts/common/packages/` files
- Verify homebrew configuration in `hosts/common/homebrew/`
- Some packages may have been moved between categories

### 2. Configuration Differences
- Review system settings in `hosts/common/darwin/system.nix`
- Check user program configurations in `users/eyad/programs/`
- Verify dotfile paths in `users/eyad/dotfiles/default.nix`

### 3. Build Errors
If you encounter build errors:
```bash
# Check for syntax errors
just check

# Build with verbose output
just darwin-debug

# Format files
just fmt
```

## 🔄 Rollback Plan

If you need to rollback to the old configuration:

1. **Restore from backup:**
   ```bash
   rm -rf ~/.config/nix-darwin
   mv ~/.config/nix-darwin-backup ~/.config/nix-darwin
   cd ~/.config/nix-darwin
   ```

2. **Rebuild old configuration:**
   ```bash
   nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .
   ```

## 📞 Getting Help

If you encounter issues during migration:

1. Check the build output for specific errors
2. Verify file paths and imports
3. Compare with the working backup
4. Use `just check` to validate configuration

## ✅ Post-Migration Checklist

- [ ] Configuration builds successfully
- [ ] All expected packages are installed
- [ ] System settings are applied correctly
- [ ] User programs work as expected
- [ ] Dotfiles are in the right locations
- [ ] Homebrew applications are installed
- [ ] Git configuration is working
- [ ] Shell and prompt are configured
- [ ] Editor configurations are loaded

## 🎉 Benefits of New Structure

After migration, you'll have:
- **Easier maintenance**: Clear organization and modular structure
- **Multi-device support**: Simple to add new hosts
- **Better documentation**: Self-documenting file structure
- **Improved workflows**: Enhanced Justfile with helpful commands
- **Future-proof**: Scalable architecture for growing needs
