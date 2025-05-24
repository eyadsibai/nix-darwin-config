# Just is a command runner, Justfile is very similar to Makefile, but simpler.

# Default recipe to display available commands
default:
    @just --list

############################################################################
#
#  Darwin related commands
#
############################################################################

# Build and switch to the Darwin configuration for eyad-m3
darwin:
    nix build .#darwinConfigurations.eyad-m3.system \
        --extra-experimental-features 'nix-command flakes'
    ./result/sw/bin/darwin-rebuild switch --flake .

# Build and switch with debug output
darwin-debug:
    nix build .#darwinConfigurations.eyad-m3.system --show-trace --verbose \
        --extra-experimental-features 'nix-command flakes'
    ./result/sw/bin/darwin-rebuild switch --flake . --show-trace --verbose

# Build Darwin configuration for a specific host
darwin-host HOST:
    nix build .#darwinConfigurations.{{HOST}}.system \
        --extra-experimental-features 'nix-command flakes'
    ./result/sw/bin/darwin-rebuild switch --flake .

############################################################################
#
#  Nix related commands
#
############################################################################

# Update flake inputs
update:
    nix flake update

# Show system profile history
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Garbage collect old generations
gc:
    # Remove all generations older than 7 days
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
    # Garbage collect all unused nix store entries
    sudo nix store gc --debug

# Format all nix files in the repository
fmt:
    nix fmt

# Check nix files for issues
check:
    statix check .
    nix flake check

# Clean build artifacts
clean:
    rm -rf result

############################################################################
#
#  Development commands
#
############################################################################

# Enter development shell
dev:
    nix develop

# Show flake info
info:
    nix flake show

# Show flake metadata
metadata:
    nix flake metadata

############################################################################
#
#  Host management
#
############################################################################

# List available host configurations
hosts:
    @echo "Available host configurations:"
    @nix eval --json .#darwinConfigurations --apply builtins.attrNames | jq -r '.[]'

# Add a new host (creates template files)
add-host HOST:
    @echo "Creating host configuration for {{HOST}}..."
    mkdir -p hosts/{{HOST}}
    cp hosts/eyad-m3/default.nix hosts/{{HOST}}/default.nix
    cp hosts/eyad-m3/hardware.nix hosts/{{HOST}}/hardware.nix
    cp hosts/eyad-m3/users.nix hosts/{{HOST}}/users.nix
    @echo "Host {{HOST}} created. Don't forget to:"
    @echo "1. Update the configuration files in hosts/{{HOST}}/"
    @echo "2. Add the host to flake.nix in the hosts attribute set"
