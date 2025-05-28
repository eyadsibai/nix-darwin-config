{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget


  programs = {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    #   vscode = {
    #      enable=true;
    #        extensions = with pkgs.vscode-extensions; [
    #   dracula-theme.theme-dracula
    #   vscodevim.vim
    #   yzhang.markdown-all-in-one
    #     ms-python.python
    #    ms-vsliveshare.vsliveshare
    # ];
    #   };
  };
}
