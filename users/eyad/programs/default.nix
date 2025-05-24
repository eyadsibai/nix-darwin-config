# User programs configuration
{ ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./starship.nix
    ./nixvim.nix
    ./helix.nix
    ./cli-tools.nix
  ];
}
