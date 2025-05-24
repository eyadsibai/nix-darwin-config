# Common packages shared across all hosts
{ pkgs, ... }:

{
  imports = [
    ./cli-tools.nix
    ./development.nix
    ./media.nix
    ./productivity.nix
  ];
}
