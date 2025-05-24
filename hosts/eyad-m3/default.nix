# Host configuration for eyad-m3
{ username, hostname, nixvim, ... }:

{
  imports = [
    ../common/darwin
    ../common/nix.nix
    ../common/packages
    ../common/homebrew
    ./hardware.nix
    ./users.nix
    ./home.nix
  ];

  # Host-specific networking
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;
}
