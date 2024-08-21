{...}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableTransience = true;

    settings = {
      #   format = builtins.concatStringsSep "" [
      #   "$nix_shell"
      #   "$os"
      #   "$directory"
      #   "$container"
      #   "$git_branch $git_status"
      #   "$python"
      #   "$nodejs"
      #   "$lua"
      #   "$rust"
      #   "$java"
      #   "$c"
      #   "$golang"
      #   "$cmd_duration"
      #   "$status"
      #   "$line_break"
      #   "[❯](bold purple)"
      #   ''''${custom.space}''
      # ];
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };
      aws = {
        symbol = "🅰 ";
      };
      gcloud = {
        # do not show the account/project's info
        # to avoid the leak of sensitive information when sharing the terminal
        format = "on [$symbol$active(\($region\))]($style) ";
        symbol = "🅶 ️";
      };
    };
  };
}
