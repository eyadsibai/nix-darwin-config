{ config, pkgs, username, useremail, lib, ... }:
{
  # System-level development tools configuration
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    # Nix language servers
    nixd
    nil
    nixpkgs-fmt
    statix
    alejandra

    just
    devbox
    yq-go
    atuin
    curlFull
    R
  ];

  programs.gnupg.agent.enable = true;
  programs.nix-index.enable = true;

  # Home-manager development tools configuration
  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    # Core development tools
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    programs.fzf = {
      enable = true;
    };

    programs.skim = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.zathura.enable = true;
    programs.kakoune.enable = true;
    programs.btop.enable = true;
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.jq.enable = true;

    programs.micro.enable = true;

    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "eyadsibai";
      userEmail = useremail;

      includes = [
        {
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
        br = "branch";
        co = "checkout";
        st = "status";
        ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
        ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
        cm = "commit -m";
        ca = "commit -am";
        dc = "diff --cached";
        amend = "commit --amend -m";
        update = "submodule update --init --recursive";
        foreach = "submodule foreach";
      };
    };

    # Helix editor configuration
    # programs.helix = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #       markdown-oxide
    #       nodePackages.vscode-langservers-extracted
    #       shellcheck
    #     ];
    #     settings = {
    #       editor = {
    #         color-modes = true;
    #         completion-trigger-len = 1;
    #         completion-replace = true;
    #         cursorline = true;
    #         cursor-shape = {
    #           insert = "bar";
    #           normal = "block";
    #           select = "underline";
    #         };
    #         inline-diagnostics = {
    #           cursor-line = "hint";
    #           other-lines = "error";
    #         };
    #         line-number = "relative";
    #         lsp.display-inlay-hints = true;
    #         lsp.display-messages = true;
    #         statusline.center = [ "position-percentage" ];
    #         true-color = true;
    #         whitespace.characters = {
    #           newline = "↴";
    #           tab = "⇥";
    #         };
    #         bufferline = "always";
    #         text-width = 79;
    #         rulers = [ 80 ];
    #         auto-save = true;
    #         whitespace.render = {
    #           newline = "all";
    #           space = "none";
    #           nbsp = "all";
    #           tab = "none";
    #         };
    #         indent-guides.render = true;
    #       };
    #       keys.normal.space.u = {
    #         f = ":format";
    #         w = ":set whitespace.render all";
    #         W = ":set whitespace.render none";
    #       };
    #     };

    #     languages = {
    #       language =
    #         let
    #           deno = lang: {
    #             command = lib.getExe pkgs.deno;
    #             args = [ "fmt" "-" "--ext" lang ];
    #           };

    #           prettier = lang: {
    #             command = lib.getExe pkgs.nodePackages.prettier;
    #             args = [ "--parser" lang ];
    #           };
    #         in
    #         [
    #           {
    #             name = "bash";
    #             auto-format = true;
    #             formatter = {
    #               command = lib.getExe pkgs.shfmt;
    #               args = [ "-i" "2" ];
    #             };
    #           }
    #           {
    #             name = "clojure";
    #             injection-regex = "(clojure|clj|edn|boot|yuck)";
    #             file-types = [ "clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck" ];
    #           }
    #           {
    #             name = "cmake";
    #             auto-format = true;
    #             language-servers = [ "cmake-language-server" ];
    #             formatter = {
    #               command = lib.getExe pkgs.cmake-format;
    #               args = [ "-" ];
    #             };
    #           }
    #           {
    #             name = "javascript";
    #             auto-format = true;
    #             language-servers = [ "dprint" "typescript-language-server" ];
    #           }
    #           {
    #             name = "json";
    #             formatter = deno "json";
    #           }
    #           {
    #             name = "markdown";
    #             language-servers = [ "dprint" "markdown-oxide" ];
    #           }
    #           {
    #             name = "python";
    #             auto-format = true;
    #             language-servers = [
    #               "basedpyright"
    #               "ruff"
    #               "pylsp"
    #               "jedi-language-server"
    #             ];
    #           }
    #           {
    #             name = "qml";
    #             language-servers = [ "qmlls" ];
    #           }
    #           {
    #             name = "typescript";
    #             auto-format = true;
    #             language-servers = [ "dprint" "typescript-language-server" ];
    #           }
    #           {
    #             name = "typst";
    #             auto-format = true;
    #             language-servers = [ "tinymist" ];
    #           }
    #           {
    #             name = "yaml";
    #             auto-format = true;
    #             language-servers = [ "yaml-language-server" ];
    #           }
    #           {
    #             name = "rust";
    #             auto-format = true;
    #             language-servers = [ "rust-analyzer" ];
    #           }
    #           {
    #             name = "jsonnet";
    #             auto-format = true;
    #             language-servers = [ "jsonnet-language-server" ];
    #           }
    #           {
    #             name = "lua";
    #             auto-format = true;
    #             language-servers = [ "lua-language-server" ];
    #           }
    #           {
    #             name = "zig";
    #             auto-format = true;
    #             language-servers = [ "zig-analyzer" ];
    #           }
    #           {
    #             name = "css";
    #             auto-format = true;
    #             formatter = prettier "css";
    #           }
    #           {
    #             name = "scss";
    #             auto-format = true;
    #             formatter = prettier "scss";
    #           }
    #           {
    #             name = "html";
    #             auto-format = true;
    #             formatter = prettier "html";
    #           }
    #           {
    #             name = "typescriptreact";
    #             auto-format = true;
    #             formatter = prettier "typescriptreact";
    #           }
    #           {
    #             name = "javascriptreact";
    #             auto-format = true;
    #             formatter = prettier "javascriptreact";
    #           }
    #           {
    #             name = "vue";
    #             auto-format = true;
    #             formatter = prettier "vue";
    #           }
    #           {
    #             name = "json5";
    #             auto-format = true;
    #             formatter = prettier "json5";
    #           }
    #         ];

    #       language-server = {
    #         basedpyright.command = "${pkgs.basedpyright}/bin/basedpyright-langserver";

    #         bash-language-server = {
    #           command = lib.getExe pkgs.bash-language-server;
    #           args = [ "start" ];
    #         };

    #         clangd = {
    #           command = "${pkgs.clang-tools}/bin/clangd";
    #           clangd.fallbackFlags = [ "-std=c++2b" ];
    #         };

    #         cmake-language-server = {
    #           command = lib.getExe pkgs.cmake-language-server;
    #         };

    #         deno-lsp = {
    #           command = lib.getExe pkgs.deno;
    #           args = [ "lsp" ];
    #           environment.NO_COLOR = "1";
    #           config.deno = {
    #             enable = true;
    #             lint = true;
    #             unstable = true;
    #             suggest = {
    #               completeFunctionCalls = false;
    #               imports = { hosts."https://deno.land" = true; };
    #             };
    #             inlayHints = {
    #               enumMemberValues.enabled = true;
    #               functionLikeReturnTypes.enabled = true;
    #               parameterNames.enabled = "all";
    #               parameterTypes.enabled = true;
    #               propertyDeclarationTypes.enabled = true;
    #               variableTypes.enabled = true;
    #             };
    #           };
    #         };

    #         dprint = {
    #           command = lib.getExe pkgs.dprint;
    #           args = [ "lsp" ];
    #         };

    #         nil = {
    #           command = lib.getExe pkgs.nil;
    #           config.nil.formatting.command = [ "${lib.getExe pkgs.alejandra}" "-q" ];
    #         };

    #         qmlls = {
    #           command = "${pkgs.qt6.qtdeclarative}/bin/qmlls";
    #           args = [ "-E" ];
    #         };

    #         tinymist = {
    #           command = lib.getExe pkgs.tinymist;
    #           config = {
    #             exportPdf = "onType";
    #             outputPath = "$root/target/$dir/$name";
    #             formatterMode = "typstyle";
    #             formatterPrintWidth = 80;
    #           };
    #         };

    #         typescript-language-server = {
    #           command = lib.getExe pkgs.nodePackages.typescript-language-server;
    #           args = [ "--stdio" ];
    #           config = {
    #             typescript-language-server.source = {
    #               addMissingImports.ts = true;
    #               fixAll.ts = true;
    #               organizeImports.ts = true;
    #               removeUnusedImports.ts = true;
    #               sortImports.ts = true;
    #             };
    #           };
    #         };

    #         ruff = {
    #           command = lib.getExe pkgs.ruff;
    #           args = [ "server" ];
    #         };

    #         vscode-css-language-server = {
    #           command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-css-languageserver";
    #           args = [ "--stdio" ];
    #           config = {
    #             provideFormatter = true;
    #             css.validate.enable = true;
    #             scss.validate.enable = true;
    #           };
    #         };
    #       };
    #     };
    #   };

    #   home.file.".dprint.json".source = builtins.toFile "dprint.json" (builtins.toJSON {
    #     lineWidth = 80;
    #     typescript = {
    #       quoteStyle = "preferSingle";
    #       binaryExpression.operatorPosition = "sameLine";
    #     };
    #     json.indentWidth = 2;
    #     excludes = [ "**/*-lock.json" ];
    #     plugins = [
    #       "https://plugins.dprint.dev/typescript-0.93.0.wasm"
    #       "https://plugins.dprint.dev/json-0.19.3.wasm"
    #       "https://plugins.dprint.dev/markdown-0.17.8.wasm"
    #     ];
    #   });
  };
}
