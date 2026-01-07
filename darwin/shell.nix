{ config, pkgs, username, lib, ... }:
{
  # System-level shell configuration
  programs.zsh.enable = true;

  # Home-manager shell configuration
  home-manager.users.${username} = {

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      initContent = ''
        export PATH="$HOME/.local/bin:$PATH"

        if [[ $(uname -m) == 'arm64' ]]; then
         eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';
    };

    programs.nushell = {
      enable = true;
    };

    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    programs.yazi = {
      enable = true;
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableTransience = true;

      settings = {
        character = {
          success_symbol = "[›](bold green)";
          error_symbol = "[›](bold red)";
        };
        aws = {
          symbol = "🅰 ";
        };
        gcloud = {
          format = "on [$symbol$active(\($region\))]($style) ";
          symbol = "🅶 ️";
        };
      };
    };
  };
}
