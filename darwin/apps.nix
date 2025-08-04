{ config, pkgs, username, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # Communication & Social
    discord
    # betterdiscord-installer
    slack
    teams
    telegram-desktop
    signal-desktop-bin
    zoom-us

    # Browsers
    firefox
    google-chrome
    # qutebrowser

    # Media & Entertainment
    iina
    spotify
    spotify-player
    losslesscut-bin
    ffmpeg-full
    feh
    diff-pdf

    # Productivity & Notes
    nb
    cointop

    # Utilities
    m-cli
    flameshot
    soundsource
    appcleaner
    localsend
    nmap
    wireshark

    # Development Applications
    insomnia
    colima
    docker

    # Editors (GUI)
    zed-editor
    rstudio

    # AI Tools
    claude-code
    gpt-cli

    # Archive tools
    zip
    xz
    unzip
    p7zip

    # System utilities
    wget
    curl
    httpie
    duf
    dust
    duf
    tree
    file
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg
    socat
    caddy

    # Fun
    cowsay

    # Terminal utilities
    glow # markdown previewer in terminal
    tldr
    ttyd
    lazysql
    jujutsu
    gg-jj
    jjui
    lazyjj
    gemini-cli

    opencode
    uv
    nodejs
    # helix
    # kakoune

  ];

  services.tailscale = {
    enable = true;

  };

  # services.jankyborders = {
  #   enable = true;
  #   style = "round";
  #   width = 6.0;
  #   hidpi = true;
  #   active_color = "0xc0e2e2e3";
  #   inactive_color = "0xc02c2e34";
  #   background_color = "0x302c2e34";
  #   ax_focus = false;
  # };

  # services.karabiner-elements.enable = true;


  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    masApps = {
      keynote = 409183694;
      numbers = 409203825;
      pages = 409201541;
      "amazon prime videos" = 545519333;
      bitwarden = 1352778147;
      Vimari = 1480933944;
      grab2text = 6475956137;
      trello = 1278508951;
      windows-app = 1295203466;
    };

    taps = [
      "homebrew/services"
      "homebrew/bundle"
      # "FelixKratz/formulae"
      "nikitabobko/tap"
      "dimentium/autoraise"
      "localsend/localsend"
      "colindean/fonts-nonfree"
    ];

    brews = [
      "kakoune"
      "helix"
    ];

    casks = [
      "visual-studio-code"
      "akiflow"
      "raycast"
      "readdle-spark"
      "wezterm"
      "font-sf-pro"
      "font-sf-mono"
      "sf-symbols"
      "capacities"
      "netdownloadhelpercoapp"
      "steam"
      "jdownloader"
      "send-to-kindle"
      "font-microsoft-office"
      "webex-meetings"
      "microsoft-remote-desktop"
      "rocket"
      "yandex-disk"
      "desktoppr"
      "zen"
      "floorp"
      "trae"
      "meetingbar"
      "homerow"
      "qutebrowser"
      "docker-desktop"
      "hey-desktop"
      "chatgpt"
      "basecamp"
      "plex"
      "raindropio"
      "claude"
      "ticktick"
      "notion"
      "grammarly-desktop"
      "linear-linear"
      "twist"
      "intellij-idea"
      "anytype"
      "stats"
      "dupeguru"
      "imageoptim"
      "boop"
      "transnomino"
      "hammerspoon"
      "only-switch"
      "shottr"
      "the-unarchiver"
      "hiddenbar"
      "reader"
      "wechat"
      "warp"
      "siyuan"
      "canva"
      "actual"
      "huggingchat"

      "dropbox"
      "keyboardcleantool"
    ];
  };

  # system.activationScripts.applications.text =
  #   let
  #     env = pkgs.buildEnv {
  #       name = "system-applications";
  #       paths = config.environment.systemPackages;
  #       pathsToLink = "/Applications";
  #     };

  #     setupScript = pkgs.writeShellScript "setup-nix-applications" ''
  #       set -euo pipefail

  #       apps_dir="/Applications/Nix Apps"
  #       env_apps_dir="${env}/Applications"

  #       echo "Setting up $apps_dir..." >&2

  #       # Clean and recreate the directory
  #       if [[ -d "$apps_dir" ]]; then
  #         rm -rf "$apps_dir"
  #       fi
  #       mkdir -p "$apps_dir"

  #       # Check if source directory exists
  #       if [[ ! -d "$env_apps_dir" ]]; then
  #         echo "No applications directory found at $env_apps_dir" >&2
  #         exit 0
  #       fi

  #       # Process each application
  #       shopt -s nullglob
  #       for app_link in "$env_apps_dir"/*; do
  #         if [[ -L "$app_link" ]]; then
  #           app_target=$(readlink "$app_link")
  #           app_name=$(basename "$app_target")

  #           if [[ -n "$app_target" && -d "$app_target" ]]; then
  #             echo "Creating alias for $app_name" >&2
  #             if ! "${pkgs.mkalias}/bin/mkalias" "$app_target" "$apps_dir/$app_name"; then
  #               echo "Warning: Failed to create alias for $app_name" >&2
  #             fi
  #           else
  #             echo "Warning: Skipping invalid target for $app_link" >&2
  #           fi
  #         fi
  #       done

  #       echo "Applications setup complete" >&2
  #     '';
  #   in
  #   pkgs.lib.mkForce "${setupScript}";


  home-manager.users.${username} = {

    programs = {
      lazygit.enable = true;
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      bun = {
        enable = true;
      };

      yt-dlp = {
        enable = true;
      };
      firefox.enable = true;
      lapce.enable = true;
      mpv = {
        enable = true;
        config = {
          profile = "gpu-hq";
          force-window = true;
          ytdl-format = "bestvideo+bestaudio";
          cache-default = 4000000;
        };
      };

      nnn = {
        enable = true;
        bookmarks = {
          D = "~/Downloads";
          p = "~/dev";
          c = "~/.config";
        };
        plugins = {
          src = (pkgs.fetchFromGitHub {
            owner = "jarun";
            repo = "nnn";
            rev = "v4.9";
            sha256 = "sha256-g19uI36HyzTF2YUQKFP4DE2ZBsArGryVHhX79Y0XzhU=";
          }) + "/plugins";
          mappings = {
            p = "preview-tui";
            o = "fzopen";
          };
        };
      };

      aria2 = {
        enable = true;
        settings = {
          max-connection-per-server = 4;
          split = 4;
          min-split-size = "1M";
          disk-cache = "64M";
          file-allocation = "falloc";
          continue = true;
          max-concurrent-downloads = 5;
        };
      };
      gpg = {
        enable = true;
        settings = {
          trust-model = "tofu+pgp";
          throw-keyids = false;
          no-emit-version = true;
          no-comments = true;
        };
        scdaemonSettings = {
          disable-ccid = true;
        };
      };

    };


  };
}
