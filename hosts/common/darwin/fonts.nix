# Font configuration
{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Icon fonts
      material-design-icons
      font-awesome
      
      # Nerd Fonts
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      
      # SketchyBar font
      sketchybar-app-font
    ];
  };
}
