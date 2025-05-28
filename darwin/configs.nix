{ config, pkgs, username, lib, ... }:
{

  home-manager.users.${username} = {

    # Configuration files
    home.file.".config/borders/bordersrc" = {
      source = ../configs/bordersrc;
    };

    # Uncomment these if you want to enable them:
    # home.file.".config/aerospace/aerospace.toml" = {
    #   source = ../configs/aerospace.toml;
    # };
    # home.file.".config/sketchybar" = {
    #   source = ../configs/sketchybar;
    #   recursive = true;
    # };
  };
}
