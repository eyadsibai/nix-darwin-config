{ pkgs
, lib
, ...
}: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-platforms = "x86_64-darwin aarch64-darwin"; # For Rosetta 2
  };

  nix.settings.trusted-substituters = [ "https://cache.flox.dev" ];
  nix.settings.trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];


  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # nixpkgs.config.packageOverrides = prev: {
  #   inherit nixcasks;
  # };


  ids.gids.nixbld = 30000;

  nix.package = pkgs.nix;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 5d";
  };

  nix.optimise.automatic = true;
}
