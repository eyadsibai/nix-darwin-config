{ pkgs
, lib
, nixcasks
, ...
}: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-platforms = "x86_64-darwin aarch64-darwin"; # For Rosetta 2
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.packageOverrides = prev: {
    inherit nixcasks;
  };


  ids.gids.nixbld = 30000;

  nix.package = pkgs.nix;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nix.optimise.automatic = true;
}
