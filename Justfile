# Just is a command runner, Justfile is very similar to Makefile, but simpler.


############################################################################
#
#  Darwin related commands
#
############################################################################

darwin:
  nix build .#darwinConfigurations.eyad-air.system \
    --extra-experimental-features 'nix-command flakes'
  ./result/sw/bin/darwin-rebuild switch --flake .

darwin-debug:
  nix build .#darwinConfigurations.eyad-air.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes'
  ./result/sw/bin/darwin-rebuild switch --flake . --show-trace --verbose

############################################################################
#
#  Nix related commands
#
############################################################################

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # Remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
  # Garbage collect all unused nix store entries
  sudo nix store gc --debug

fmt:
  # Format the nix files in this repo
  nix fmt

clean:
  rm -rf result
