# System-wide programs configuration
{ ... }:

{
  # Enable GnuPG agent
  programs.gnupg.agent.enable = true;
  
  # Enable nix-index for command-not-found functionality
  programs.nix-index.enable = true;
  
  # Set default editor
  environment.variables.EDITOR = "nvim";
}
