# Home Manager configuration for eyad-m3
{ pkgs, nixvim, username, useremail, lib, ... }:

{
  # Home Manager configuration
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      if [[ $(uname -m) == 'arm64' ]]; then
       eval "$(/opt/homebrew/bin/brew shellenv)"
      fi'';
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

  # Git configuration
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "eyadsibai";
    userEmail = useremail;

    includes = [
      {
        # use diffrent email & name for work
        path = "~/dev/.gitconfig";
        condition = "gitdir:~/dev/";
      }
    ];

    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
      };
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };

  # Starship prompt
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
        # do not show the account/project's info
        # to avoid the leak of sensitive information when sharing the terminal
        format = "on [$symbol$active(\($region\))]($style) ";
        symbol = "🅶 ️";
      };
    };
  };

  # NixVim configuration
  programs.nixvim = {
    enable = true;

    # colorschemes.gruvbox.enable = true;
    colorschemes.catppuccin.enable = true;

    plugins = {
      lightline.enable = true;
      nvim-tree.enable = true;

      gitsigns.enable = true;

      fugitive.enable = true;

      diffview.enable = true;

      neogit.enable = true;

      web-devicons.enable = true;

      telescope.enable = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };

  # CLI tools
  programs.yt-dlp.enable = true;
  programs.kakoune.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.jq.enable = true;
  programs.zathura.enable = true;

  # Helix editor
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      markdown-oxide
      nodePackages.vscode-langservers-extracted
      shellcheck
    ];
    settings = {
      editor = {
        color-modes = true;
        completion-trigger-len = 1;
        completion-replace = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
        line-number = "relative";
        lsp.display-inlay-hints = true;
        lsp.display-messages = true;
        statusline.center = [ "position-percentage" ];
        true-color = true;
        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
        bufferline = "always";
        text-width = 79;
        rulers = [ 80 ];
        auto-save = true;
        whitespace.render = {
          newline = "all";
          space = "none";
          nbsp = "all";
          tab = "none";
        };
        indent-guides.render = true;
      };
      keys.normal.space.u = {
        f = ":format"; # format using LSP formatter
        w = ":set whitespace.render all";
        W = ":set whitespace.render none";
      };
    };

    languages = {
      language =
        let
          deno = lang: {
            command = lib.getExe pkgs.deno;
            args = [ "fmt" "-" "--ext" lang ];
          };
          prettier = lang: {
            command = lib.getExe pkgs.nodePackages.prettier;
            args = [ "--parser" lang ];
          };
        in
        [
          {
            name = "bash";
            auto-format = true;
            formatter = {
              command = lib.getExe pkgs.shfmt;
              args = [ "-i" "2" ];
            };
          }
          {
            name = "rust";
            auto-format = true;
            language-servers = [ "rust-analyzer" ];
          }
          {
            name = "nix";
            auto-format = true;
            language-servers = [ "nil" ];
          }
        ];

      language-server = {
        nil = {
          command = lib.getExe pkgs.nil;
          config.nil.formatting.command = [ "${lib.getExe pkgs.alejandra}" "-q" ];
        };
        rust-analyzer = {
          command = lib.getExe pkgs.rust-analyzer;
        };
      };
    };
  };

  # Dotfiles
  home.file.".config/borders/bordersrc" = {
    source = ./bordersrc;
  };

  home.file.".dprint.json".source = builtins.toFile "dprint.json" (builtins.toJSON {
    lineWidth = 80;
    typescript = {
      quoteStyle = "preferSingle";
      binaryExpression.operatorPosition = "sameLine";
    };
    json.indentWidth = 2;
    excludes = [ "**/*-lock.json" ];
    plugins = [
      "https://plugins.dprint.dev/typescript-0.93.0.wasm"
      "https://plugins.dprint.dev/json-0.19.3.wasm"
      "https://plugins.dprint.dev/markdown-0.17.8.wasm"
    ];
  });
}
