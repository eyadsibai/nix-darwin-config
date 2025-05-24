# Nix configuration shared across all hosts
{ inputs, lib, ... }:

{
  # Enable flakes and new command
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    
    # Trusted users for multi-user nix
    trusted-users = [ "@admin" ];
    
    # Substituters for faster builds
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    
    # Keep build dependencies for debugging
    keep-derivations = true;
    keep-outputs = true;
  };
  
  # Auto-optimize store (correct way)
  nix.optimise.automatic = true;
  
  # Garbage collection
  nix.gc = {
    automatic = true;
    interval = { Weekday = 7; }; # Run weekly on Sunday
    options = "--delete-older-than 7d";
  };
  
  # Registry for flake commands
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  
  # Add inputs to legacy channels for compatibility
  nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") inputs;
}
