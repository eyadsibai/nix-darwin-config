# Ultimate Nix Darwin Configuration

A comprehensive, well-organized nix-darwin configuration for managing multiple macOS devices with a clean, modular structure.

## ✨ Features

- **Multi-device support**: Easy configuration for multiple hosts
- **Modular structure**: Clean separation of concerns
- **Home Manager integration**: User-level configuration management
- **Comprehensive package management**: Both Nix packages and Homebrew casks
- **Development-ready**: Pre-configured editors (Neovim, Helix) and tools
- **Dotfiles management**: Centralized configuration files
- **Easy maintenance**: Simple commands for updates and management

## 🏗️ Structure

```
.
├── flake.nix                 # Main flake configuration
├── Justfile                  # Command runner with helpful recipes
├── hosts/                    # Host-specific configurations
│   ├── common/              # Shared configuration modules
│   │   ├── darwin/          # macOS system settings
│   │   ├── packages/        # System packages organized by category
│   │   ├── homebrew/        # Homebrew configuration
│   │   └── nix.nix          # Nix settings
│   └── eyad-m3/             # Example host configuration
│       ├── default.nix      # Host entry point
│       ├── hardware.nix     # Hardware-specific settings
│       └── users.nix        # User configuration
├── users/                   # User-specific configurations
│   └── eyad/               # Example user
│       ├── programs/        # Program configurations
│       └── dotfiles/        # Configuration files
└── wallpaper.png           # System wallpaper
```

## 🚀 Quick Start

### Prerequisites

1. Install Nix with flakes support:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. Install Homebrew:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

### Installation

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/.config/nix-darwin
   cd ~/.config/nix-darwin
   ```

2. Update the configuration:
   - Edit `flake.nix` to add your hostname to the `hosts` attribute set
   - Create a new host configuration in `hosts/your-hostname/`
   - Update user information in `flake.nix`

3. Build and apply the configuration:
   ```bash
   just darwin
   ```

## 📋 Available Commands

Use `just` to run common tasks:

```bash
# Show all available commands
just

# Build and switch to Darwin configuration
just darwin

# Build with debug output
just darwin-debug

# Build for a specific host
just darwin-host hostname

# Update flake inputs
just update

# Format nix files
just fmt

# Check configuration
just check

# Garbage collect old generations
just gc

# List available hosts
just hosts

# Add a new host configuration
just add-host new-hostname
```

## 🖥️ Adding a New Host

1. Use the helper command:
   ```bash
   just add-host your-new-hostname
   ```

2. Edit the generated files in `hosts/your-new-hostname/`

3. Add the host to `flake.nix`:
   ```nix
   hosts = {
     "eyad-m3" = {
       hostname = "eyad-m3";
       system = "aarch64-darwin";
     };
     "your-new-hostname" = {
       hostname = "your-new-hostname";
       system = "aarch64-darwin";  # or "x86_64-darwin" for Intel Macs
     };
   };
   ```

4. Build and switch:
   ```bash
   just darwin-host your-new-hostname
   ```

## 👤 User Configuration

User configurations are stored in `users/username/`:

- `programs/`: Application and tool configurations
- `dotfiles/`: Configuration files and dotfiles

To add a new user, create a new directory under `users/` and update the flake configuration.

## 📦 Package Management

### System Packages (Nix)
Organized by category in `hosts/common/packages/`:
- `cli-tools.nix`: Command-line utilities
- `development.nix`: Development tools
- `media.nix`: Media applications
- `productivity.nix`: Productivity apps

### GUI Applications (Homebrew)
Organized in `hosts/common/homebrew/`:
- `casks.nix`: GUI applications
- `brews.nix`: Command-line tools
- `mas-apps.nix`: Mac App Store applications
- `taps.nix`: Third-party repositories

## 🎨 Customization

### System Settings
macOS system preferences are configured in `hosts/common/darwin/system.nix`.

### User Programs
Individual program configurations are in `users/username/programs/`:
- `git.nix`: Git configuration
- `shell.nix`: Shell setup (zsh, nushell)
- `starship.nix`: Prompt configuration
- `nixvim.nix`: Neovim setup
- `helix.nix`: Helix editor configuration

### Dotfiles
Configuration files are managed in `users/username/dotfiles/`.

## 🔧 Maintenance

### Regular Updates
```bash
# Update all inputs
just update

# Rebuild with new inputs
just darwin

# Clean old generations
just gc
```

### Troubleshooting
```bash
# Check configuration for errors
just check

# Build with verbose output
just darwin-debug

# Show system history
just history
```

## 📚 Resources

- [Nix Darwin Manual](https://daiderd.com/nix-darwin/manual/index.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/)
- [macOS defaults](https://github.com/yannbertrand/macos-defaults)

## ⚠️ Important Notes

- **Backup your existing configuration** before applying this setup
- Some applications may require manual installation from the Mac App Store
- The first build may take a while as it downloads and builds packages
- Make sure to review and customize the configuration for your needs

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This configuration is provided as-is for educational and personal use.
