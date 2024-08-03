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
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "bitwarden-cli"
      "yt-dlp"
      "kakoune"
      "helix"
      "atuin"
      "dust"
      "btop"
      "bat"
      "tldr"

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
      "anki"
      "iina" # video player
      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      "stats" # beautiful system monitor
      "eudic" # 欧路词典

      # Development
      "insomnia" # REST client
      "wireshark" # network analyzer

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
      "vlc"
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
      "remarkable"
      "logseq"
#      "opera"
      "send-to-kindle"
      "kindle"
      "qutebrowser"
      "rectangle"
      "grammarly-desktop"
      "notion"
      "wezterm"
      "whatsapp"
      "linear-linear"
      "ticktick"
      "tailscale"
      "iina"
      "lapce"
      "zed"
      "marginnote"
      "sitesucker-pro"

      "microsoft-remote-desktop"
      "orion"

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

      "twist"

      "intellij-idea"
      "anytype"
      "raindropio"
      "logseq"
      "hiddenbar"
      "alt-tab"
      "amazon-q"
      "wave"
    ];
  };


#services = {tailscale.enable = true;
#yabai = {
 #     enable = true;
  #    enableScriptingAddition = true;
   #   # TODO: yabairc (and maybe skhdrc?) refer to sketchybarrc and related files. How should this be organized?
      # Could maybe use services.yabai.config to pass reference to skhd config dir?
    #  extraConfig = builtins.readFile (flake-root + "/config/yabai/yabairc");
#    };
 #   skhd = {
  #    # When home-manager or nix-darwin creates launchd services on Darwin, it tries to use things like $HOME in the PATH set in EnvironmentVariables in the launchd service. However, according to LaunchControl, that field does not support variable expansion. Hence $HOME/.nix-profile/bin does not end up in the PATH for skhd.
      # See https://github.com/LnL7/nix-darwin/issues/406
      # Also, nix-based string replacement does not work when reading from separate file, so we have to do that here.
   #   enable = true;
    #  skhdConfig =
     #   (builtins.readFile (flake-root + "/config/skhd/skhdrc"))
      #  + ''
#
 #         ctrl + alt - return : ${pkgs.kitty}/bin/kitty --single-instance $HOME'';
  #  };
#};

 # Fix for skhd not hot-reloading changes to config files on nix-darwin activation.
  # https://github.com/LnL7/nix-darwin/issues/333#issuecomment-1981495455
 # system.activationScripts.hotloadSKHD.text = ''
  #  su - $(logname) -c '${pkgs.skhd}/bin/skhd -r'
  #'';


  # NOTE: The config files for these services are in the users home directory. They are set in modules/darwin/home-manager as xdg.configFile's.
  # It would be better to be able to set the configs as part of the service definitions, but that is not supported.
 # services = {
  #  karabiner-elements.enable = true;
    # The sketchybar service module has a config option, but it takes the contents of sketchybarrc as argument. My config is split across multiple arguments.
   # sketchybar = {
    #  enable = true;
      # Empty config string means nix won't manage the config.
      # TODO: If we want to have the config managed by nix, we can set `config` here to a string that simply imports our usual sketchybarrc. We'd have to only use relative paths in any sketchybar config, and we'd have to point Yabai configuration at the nix-managed files as well.
      # This would make config tinkering more annoying.
     # config = "";
      # Dependencies of config
     # extraPackages = [ pkgs.jq ];
    #};
 # };

}
