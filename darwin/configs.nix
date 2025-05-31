{ config, pkgs, username, lib, ... }:
{

  home-manager.users.${username} = {

    # Configuration files


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
