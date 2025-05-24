# Command-line tools and utilities
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System utilities
    just # Command runner
    wget
    curl
    aria2
    httpie
    duf # Better df
    m-cli # macOS command line tools

    # Text processing
    micro # Simple text editor
    nixpkgs-fmt # Nix formatter
    statix # Nix linter

    # File management
    nb # Note-taking
    diff-pdf # PDF comparison

    # System monitoring
    cointop # Cryptocurrency prices

    # Development tools
    devbox # Development environments
    gpt-cli # GPT command line interface
  ];
}
