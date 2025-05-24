# Common Darwin (macOS) system configuration shared across all hosts
{ pkgs, lib, ... }:

{
  imports = [
    ./system.nix
    ./security.nix
    ./fonts.nix
    ./programs.nix
  ];

  # System state version
  system.stateVersion = 5;

  # Enable nix-darwin environment
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh nushell ];

  # Enable linux builder VM for cross-compilation
  nix.linux-builder.enable = true;
}
