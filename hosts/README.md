# Hosts Configuration

This directory contains host-specific configurations for different devices.

## Structure

- `common/` - Shared configuration modules used across all hosts
- `<hostname>/` - Individual host configurations

## Adding a New Host

1. Create a new directory with your hostname
2. Copy the `default.nix` template from an existing host
3. Customize the configuration for your specific device
4. Add the host to `flake.nix` outputs

## Host Naming Convention

Use descriptive names that include:
- Your username
- Device type (air, pro, mini, studio, etc.)
- Optional: year or generation

Examples:
- `eyad-m3-air`
- `eyad-m1-pro`
- `work-intel-mini`
