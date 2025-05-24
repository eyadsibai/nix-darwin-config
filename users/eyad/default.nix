# Home Manager configuration for user eyad
{ pkgs, nixvim, username, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./programs
    ./dotfiles
  ];

  # Home Manager configuration
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
