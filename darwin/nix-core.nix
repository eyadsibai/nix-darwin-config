{ pkgs
, lib
, nixcasks
, ...
}: {
  # enable flakes globally
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-platforms = "x86_64-darwin aarch64-darwin"; # For Rosetta 2
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.packageOverrides = prev: {
    inherit nixcasks;
  };


  ids.gids.nixbld = 30000;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;

  nix.package = pkgs.nix;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # auto-optimise-store is generally safe with modern Nix versions.
  # The issue https://github.com/NixOS/nix/issues/7273 was resolved.
  nix.optimise.automatic = true;
}
