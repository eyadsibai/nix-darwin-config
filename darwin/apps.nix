{ config, pkgs, username, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # Communication & Social
    # discord
    betterdiscord-installer
    slack
    teams
    telegram-desktop
    signal-desktop-bin
    zoom-us

    # Browsers
    # firefox
    google-chrome
    qutebrowser

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

    # Nixcasks applications
    nixcasks.chatgpt
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
    nixcasks.stats
    nixcasks.dupeguru
    nixcasks.siyuan
    nixcasks.canva
    nixcasks.actual
    nixcasks.huggingchat
    nixcasks.trae
    nixcasks.imageoptim
    nixcasks.boop
    nixcasks.transnomino
    nixcasks.hammerspoon
    nixcasks.only-switch
    nixcasks.shottr
    nixcasks.the-unarchiver
    nixcasks.hiddenbar
    nixcasks.reader
    nixcasks.docker
    nixcasks.dropbox
    nixcasks.keyboardcleantool
    nixcasks.meetingbar
  ];

  services.tailscale = {
    enable = true;

  };

  services.jankyborders = {
    enable = true;
    style = "round";
    width = 6.0;
    hidpi = true;
    active_color = "0xc0e2e2e3";
    inactive_color = "0xc02c2e34";
    background_color = "0x302c2e34";
    ax_focus = false;
  };

  # services.karabiner-elements.enable = true;


  # Homebrew configuration
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
    ];
  };

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';


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
