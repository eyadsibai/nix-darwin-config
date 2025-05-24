# Development tools and environments
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors and IDEs
    zed-editor
    claude-code
    
    # Browsers for development
    firefox
    qutebrowser
    
    # Containerization
    colima # Docker alternative for macOS
    
    # Programming languages and tools
    R # Statistical computing
    
    # Network analysis
    wireshark
    
    # API testing
    insomnia
    
    # Image viewer
    feh
  ];
}
