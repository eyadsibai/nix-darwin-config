{pkgs, ...}: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331

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
  ];

  environment.variables.EDITOR = "nvim";

  programs.gnupg.agent.enable = true;
  programs.nix-index.enable = true;

  fonts.packages = [
    pkgs.sketchybar-app-font
  ];

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
    };

    taps = [
      "homebrew/services"
      "homebrew/bundle"
      "FelixKratz/formulae"
      "nikitabobko/tap"
      "dimentium/autoraise"
      "localsend/localsend"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "bitwarden-cli"
      "atuin"
      "dust"
      "tldr"
      "m-cli"

      "sketchybar"
      "borders"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "firefox"
      "google-chrome"
      "visual-studio-code"
      "only-switch"
      # IM & audio & remote desktop & meeting
      # "telegram"
      "discord"
      "webex-meetings"
      "spotify"

      "iina" # video player
      "raycast"
      "stats" # beautiful system monitor

      # Development
      "insomnia" # REST client
      #  "wireshark" # network analyzer

      "chatgpt"

      ####  video Editing
      # "adobe-creative-cloud"
      #     "handbrake"
      # "obs"

      "the-unarchiver"
      "appcleaner"
      # "todoist"
      "akiflow"
      "soundsource"
      "karabiner-elements"
      "hammerspoon"

      "messenger"
      "raycast"
      #  "vlc"
      "yandex-disk"
      "readdle-spark"
      # "neovide"
      "logi-options-plus"
      "slack"
      "discord"
      "zoom"
      "telegram-desktop"
      "dropbox"
      "basecamp"
      "hey"
      "raindropio"
      # "remarkable"
      "logseq"
      #      "opera"
      "send-to-kindle"
      # "kindle"
      "qutebrowser"
      # "rectangle"
      "grammarly-desktop"
      "notion"
      "wezterm"
      "whatsapp"
      "linear-linear"
      "ticktick"
      "tailscale"
      "iina"
      # "lapce"
      #  "zed"
      # "sitesucker-pro"

      "microsoft-remote-desktop"
      "orion"
      "flameshot"

      # "font-3270-nerd-font"
      "font-fira-mono-nerd-font"
      # "font-inconsolata-go-nerd-font"
      # "font-inconsolata-lgc-nerd-font"
      # "font-inconsolata-nerd-font"
      # "font-monofur-nerd-font"
      # "font-overpass-nerd-font"
      "font-ubuntu-mono-nerd-font"
      # "font-agave-nerd-font"
      # "font-arimo-nerd-font"
      # "font-anonymice-nerd-font"
      # "font-aurulent-sans-mono-nerd-font"
      # "font-bigblue-terminal-nerd-font"
      # "font-bitstream-vera-sans-mono-nerd-font"
      # "font-blex-mono-nerd-font"
      "font-caskaydia-cove-nerd-font"
      # "font-code-new-roman-nerd-font"
      # "font-cousine-nerd-font"
      # "font-daddy-time-mono-nerd-font"
      # "font-dejavu-sans-mono-nerd-font"
      # "font-droid-sans-mono-nerd-font"
      # "font-fantasque-sans-mono-nerd-font"
      "font-fira-code-nerd-font"
      # "font-go-mono-nerd-font"
      # "font-gohufont-nerd-font"
      "font-hack-nerd-font"
      # "font-hasklug-nerd-font"
      # "font-heavy-data-nerd-font"
      # "font-hurmit-nerd-font"
      # "font-im-writing-nerd-font"
      "font-iosevka-nerd-font"
      "font-jetbrains-mono-nerd-font"
      # "font-lekton-nerd-font"
      # "font-liberation-nerd-font"
      "font-meslo-lg-nerd-font"
      # "font-monoid-nerd-font"
      # "font-mononoki-nerd-font"
      # "font-mplus-nerd-font"
      # "font-noto-nerd-font"
      # "font-open-dyslexic-nerd-font"
      # "font-profont-nerd-font"
      # "font-proggy-clean-tt-nerd-font"
      # "font-roboto-mono-nerd-font"
      # "font-sauce-code-pro-nerd-font"
      # "font-shure-tech-mono-nerd-font"
      # "font-space-mono-nerd-font"
      # "font-terminess-ttf-nerd-font"
      # "font-tinos-nerd-font"
      "font-ubuntu-nerd-font"
      # "font-victor-mono-nerd-font"
      "font-sf-pro"
      "sf-symbols"
      "twist"
      "font-sf-mono"
      "intellij-idea"
      "anytype"
      "raindropio"
      "logseq"
      "hiddenbar"
      # "alt-tab"
      # "amazon-q"
      # "wave"

      "aerospace"
      "cursor"
      "rocket"
      "imageoptim"
      "transnomino"
      "localsend"
	  "cardhop"
	  "fantastical"

    ];
  };

  #services = {tailscale.enable = true;};
}
