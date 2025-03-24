{ pkgs
, lib
, ...
}: {
  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

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

  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
  nix.settings = { };

  nix.optimise.automatic = true;
  # nix = {
  #   extraOptions =
  #     ''
  #     ''
  #     + pkgs.lib.optionalString (pkgs.system == "aarch64-darwin") ''
  #       extra-platforms = x86_64-darwin aarch64-darwin
  #     '';
  # };
}
