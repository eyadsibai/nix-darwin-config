# Media and entertainment applications
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Video players
    iina
    
    # Audio tools
    soundsource
    
    # Screenshots and screen recording
    flameshot
    
    # Music streaming
    spotify
    
    # File sharing
    localsend
  ];
}
