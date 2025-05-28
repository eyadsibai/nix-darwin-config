{ config, pkgs, username, lib, ... }:
{


  environment.systemPackages = with pkgs; [
    # neovim
    just # use Justfile to simplify nix-darwin's commands
    micro
    nixpkgs-fmt
    statix
    wget
    curl
    aria2
    httpie
    duf
    devbox
    feh
    diff-pdf
    nb
    # texlive.combined.scheme-full
    cointop
    colima
    firefox

    discord
    m-cli
    R
    iina
    insomnia
    wireshark
    flameshot
    slack
    soundsource
    zoom-us
    appcleaner
    teams
    telegram-desktop
    spotify
    signal-desktop-bin
    qutebrowser
    zed-editor # zed-editor-fhs
    # handbrake
    claude-code
    gpt-cli
    localsend
    # ghostty
    # bitwarden-cli
    google-chrome
    losslesscut-bin
    lapce
    rstudio
    nmap
    #### security-tools
    # nuclei
    # metasploit
    # burpsuite
    # EternalBlue not available 

    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    caddy
    gnupg

    # productivity
    glow # markdown previewer in terminal
    spotify-player # A command-line Spotify client
    tldr
    dust
    atuin # A shell history manager
    ripgrep
    # dnote
    ttyd
    yt-dlp
    ffmpeg-full
    lazysql
    curlFull




    nixcasks.chatgpt
    # nixcasks.messenger
    nixcasks.basecamp
    nixcasks.hey
    nixcasks.capacities
    nixcasks.plex
    nixcasks.raindropio
    nixcasks.claude
    nixcasks.ticktick
    nixcasks.notion
    nixcasks.grammarly-desktop
    nixcasks.linear-linear

    nixcasks.twist
    nixcasks.intellij-idea
    nixcasks.anytype
    nixcasks.stats # beautiful system monitor
    nixcasks.dupeguru
    nixcasks.siyuan
    nixcasks.canva
    nixcasks.actual
    nixcasks.huggingchat
    nixcasks.trae
    nixcasks.imageoptim
    nixcasks.boop
    nixcasks.transnomino
    # nixcasks.whatsapp

    nixcasks.hammerspoon

    nixcasks.only-switch

    nixcasks.shottr
    nixcasks.the-unarchiver

  ];

  environment.variables.EDITOR = "nvim";

  programs.gnupg.agent.enable = true;
  programs.nix-index.enable = true;

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
      upgrade = true;
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.
      # "canva" = 897446215;
      keynote = 409183694;
      numbers = 409203825;
      pages = 409201541;
      "amazon prime videos" = 545519333;
      bitwarden = 1352778147;
      Vimari = 1480933944;
      grab2text = 6475956137;
      # "Microsoft OneNote" = 410396684;
      # "Microsoft Outlook" = 985367838;
      # "Microsoft Teams" = 1417478139;
      # "Microsoft Remote Desktop" = 1295203466;
      # "Microsoft Excel" = 462058435;
      # "Microsoft Word" = 462054704;
      # "Microsoft PowerPoint" = 462062816;

      # Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
      trello = 1278508951;
      windows-app = 1295203466;
    };

    taps = [
      "homebrew/services"
      "homebrew/bundle"
      "FelixKratz/formulae"
      "nikitabobko/tap"
      "dimentium/autoraise"
      "localsend/localsend"
      "colindean/fonts-nonfree"
      # "dnote/dnote"
    ];

    # `brew install`
    brews = [
      "borders"
    ];

    # `brew install --cask`
    casks = [
      "visual-studio-code"
      "akiflow"
      "raycast"
      "yandex-disk"
      "readdle-spark"
      # "neovide"
      # "logi-options-plus"
      "dropbox"
      "wezterm"
      "tailscale"

      "font-sf-pro"
      "font-sf-mono"
      "sf-symbols"

      "hiddenbar"

      "capacities"
      "reader"
      "netdownloadhelpercoapp"

      "steam"
      "jdownloader"
      "docker"

      "send-to-kindle"

      ## cannot be installed via nixcasks
      "font-microsoft-office"
      "webex-meetings"
      "microsoft-remote-desktop"
      "karabiner-elements"
      "rocket"
    ];
  };

  home-manager.users.${username} = {
    programs.zathura.enable = true;
    programs.yt-dlp.enable = true;
    programs.kakoune.enable = true;
    programs.btop.enable = true;
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.jq.enable = true;


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
        programs.helix.languages = {
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
                name = "clojure";
                injection-regex = "(clojure|clj|edn|boot|yuck)";
                file-types = [ "clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck" ];
              }
              {
                name = "cmake";
                auto-format = true;
                language-servers = [ "cmake-language-server" ];
                formatter = {
                  command = lib.getExe pkgs.cmake-format;
                  args = [ "-" ];
                };
              }
              {
                name = "javascript";
                auto-format = true;
                language-servers = [ "dprint" "typescript-language-server" ];
              }
              {
                name = "json";
                formatter = deno "json";
              }
              {
                name = "markdown";
                language-servers = [ "dprint" "markdown-oxide" ];
              }
              {
                name = "python";
                auto-format = true;
                language-servers = [
                  "basedpyright"
                  "ruff"
                  "pylsp"
                  "jedi-language-server"

                ];
              }
              {
                name = "qml";
                language-servers = [ "qmlls" ];
              }
              {
                name = "typescript";
                auto-format = true;
                language-servers = [ "dprint" "typescript-language-server" ];
              }
              {
                name = "typst";
                auto-format = true;
                language-servers = [ "tinymist" ];
              }
              {
                name = "yaml";
                auto-format = true;
                language-servers = [ "yaml-language-server" ];
              }
              {
                name = "rust";
                auto-format = true;
                language-servers = [ "rust-analyzer" ];
              }
              {
                name = "jsonnet";
                auto-format = true;
                language-servers = [ "jsonnet-language-server" ];
              }
              {
                name = "lua";
                auto-format = true;
                language-servers = [ "lua-language-server" ];
              }
              {
                name = "zig";
                auto-format = true;
                language-servers = [ "zig-analyzer" ];
              }
              {
                name = "css";
                auto-format = true;
                formatter = prettier "css";
              }
              {
                name = "scss";
                auto-format = true;
                formatter = prettier "scss";
              }
              {
                name = "html";
                auto-format = true;
                formatter = prettier "html";
              }
              {
                name = "typescriptreact";
                auto-format = true;
                formatter = prettier "typescriptreact";
              }
              {
                name = "javascriptreact";
                auto-format = true;
                formatter = prettier "javascriptreact";
              }
              {
                name = "vue";
                auto-format = true;
                formatter = prettier "vue";
              }
              {
                name = "json5";
                auto-format = true;
                formatter = prettier "json5";
              }

            ];
          language-server = {
            basedpyright.command = "${pkgs.basedpyright}/bin/basedpyright-langserver";

            bash-language-server = {
              command = lib.getExe pkgs.bash-language-server;
              args = [ "start" ];
            };

            clangd = {
              command = "${pkgs.clang-tools}/bin/clangd";
              clangd.fallbackFlags = [ "-std=c++2b" ];
            };

            cmake-language-server = {
              command = lib.getExe pkgs.cmake-language-server;
            };

            deno-lsp = {
              command = lib.getExe pkgs.deno;
              args = [ "lsp" ];
              environment.NO_COLOR = "1";
              config.deno = {
                enable = true;
                lint = true;
                unstable = true;
                suggest = {
                  completeFunctionCalls = false;
                  imports = { hosts."https://deno.land" = true; };
                };
                inlayHints = {
                  enumMemberValues.enabled = true;
                  functionLikeReturnTypes.enabled = true;
                  parameterNames.enabled = "all";
                  parameterTypes.enabled = true;
                  propertyDeclarationTypes.enabled = true;
                  variableTypes.enabled = true;
                };
              };
            };

            dprint = {
              command = lib.getExe pkgs.dprint;
              args = [ "lsp" ];
            };

            nil = {
              command = lib.getExe pkgs.nil;
              config.nil.formatting.command = [ "${lib.getExe pkgs.alejandra}" "-q" ];
            };

            qmlls = {
              command = "${pkgs.qt6.qtdeclarative}/bin/qmlls";
              args = [ "-E" ];
            };

            tinymist = {
              command = lib.getExe pkgs.tinymist;
              config = {
                exportPdf = "onType";
                outputPath = "$root/target/$dir/$name";
                formatterMode = "typstyle";
                formatterPrintWidth = 80;
              };
            };

            typescript-language-server = {
              command = lib.getExe pkgs.nodePackages.typescript-language-server;
              args = [ "--stdio" ];
              config = {
                typescript-language-server.source = {
                  addMissingImports.ts = true;
                  fixAll.ts = true;
                  organizeImports.ts = true;
                  removeUnusedImports.ts = true;
                  sortImports.ts = true;
                };
              };
            };

            ruff = {
              command = lib.getExe pkgs.ruff;
              args = [ "server" ];
            };

            vscode-css-language-server = {
              command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-css-languageserver";
              args = [ "--stdio" ];
              config = {
                provideFormatter = true;
                css.validate.enable = true;
                scss.validate.enable = true;
              };
            };
          };
        };

        home.file.".dprint.json".source = builtins.toFile "dprint.json" (builtins.toJSON {
          lineWidth = 80;

          # This applies to both JavaScript & TypeScript
          typescript = {
            quoteStyle = "preferSingle";
            binaryExpression.operatorPosition = "sameLine";
          };

          json.indentWidth = 2;

          excludes = [
            "**/*-lock.json"
          ];

          plugins = [
            "https://plugins.dprint.dev/typescript-0.93.0.wasm"
            "https://plugins.dprint.dev/json-0.19.3.wasm"
            "https://plugins.dprint.dev/markdown-0.17.8.wasm"
          ];
        });
      };
    };

  };

  # services = {tailscale.enable = true;};
}

