{ config, pkgs, username, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # Communication & Social
    discord
    slack
    teams
    telegram-desktop
    signal-desktop-bin
    zoom-us

    # Browsers
    firefox
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
    lapce
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
    aria2
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
    nnn # terminal file manager
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
  ];

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
      "FelixKratz/formulae"
      "nikitabobko/tap"
      "dimentium/autoraise"
      "localsend/localsend"
      "colindean/fonts-nonfree"
    ];

    brews = [
      "borders"
    ];

    casks = [
      "visual-studio-code"
      "akiflow"
      "raycast"
      "yandex-disk"
      "readdle-spark"
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
      "font-microsoft-office"
      "webex-meetings"
      "microsoft-remote-desktop"
      "karabiner-elements"
      "rocket"
    ];
  };

  home-manager.users.${username} = {

    programs.yt-dlp = {
      enable = true;
    };
  };
}
