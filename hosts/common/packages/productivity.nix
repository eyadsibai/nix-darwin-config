# Productivity and communication applications
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Communication
    # discord
    slack
    telegram-desktop
    signal-desktop-bin

    # Video conferencing
    zoom-us
    teams

    # System maintenance
    appcleaner
  ];
}
