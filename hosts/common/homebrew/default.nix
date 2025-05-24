# Homebrew configuration for macOS-specific applications
{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Uninstall unlisted formulae
      upgrade = true;
    };

    # Import specific homebrew configurations
    taps = import ./taps.nix;
    brews = import ./brews.nix;
    casks = import ./casks.nix;
    masApps = import ./mas-apps.nix;
  };
}
