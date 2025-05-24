# Dotfiles and configuration files
{ ... }:

{
  # Configuration files
  home.file.".config/borders/bordersrc" = { 
    source = ./bordersrc; 
  };
  
  # Aerospace configuration (commented out as per original)
  # home.file.".config/aerospace/aerospace.toml" = {
  #   source = ./aerospace.toml;
  # };
  
  # SketchyBar configuration (commented out as per original)
  # home.file.".config/sketchybar/sketchybarrc" = {
  #   source = ./sketchybar/sketchybarrc;
  # };
  # home.file.".config/sketchybar/plugins" = {
  #   source = ./sketchybar/plugins;
  #   recursive = true;
  # };
  # home.file.".config/sketchybar" = {
  #   source = ./sketchybar;
  #   recursive = true;
  # };
}
