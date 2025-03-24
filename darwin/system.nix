{ pkgs, ... }:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  Incomplete list of macOS `defaults` commands :
#    https://github.com/yannbertrand/macos-defaults
#
###################################################################################
{
  system.stateVersion = 5;
  system = {
    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock

      # customize dock
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        show-recents = false; # disable recent apps

        orientation = "bottom"; # dock position
        show-process-indicators = false;
        static-only = true;

        # 1: Disabled
        # 2: Mission Control
        # 3: Application Windows
        # 4: Desktop
        # 5: Start Screen Saver
        # 6: Disable Screen Saver
        # 7: Dashboard
        # 10: Put Display to Sleep
        # 11: Launchpad
        # 12: Notification Center
        # 13: Lock Screen
        # 14: Quick Note

        # customize Hot Corners
        wvous-tl-corner = 1; # top-left
        wvous-tr-corner = 1; # top-right
        wvous-bl-corner = 1; # bottom-left
        wvous-br-corner = 1; # bottom-right

        tilesize = 32;

        dashboard-in-overlay = true; # show dashboard as overlay

        # Whether to arrange spaces based on most recent use
        mru-spaces = false;
        launchanim = false; # disable launch animation

        # see https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
        # expose-group-apps = true;
      };

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
      };

      # customize trackpad
      trackpad = {
        # tap - 轻触触摸板, click - 点击触摸板
        Clicking = true; # enable tap to click(轻触触摸板相当于点击)
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = true; # enable three finger drag
        # Enable silent clicking
        ActuationStrength = 0;
      };

      # universalaccess.reduceMotion = true;

      # Trackpad speed, 0 to 3
      #     "com.apple.trackpad.scaling" = 1.0;
      # Sounds like something I want, but it actually reduces motions related to trackpad movements which I want to keep.
      #universalaccess = {
      # reduceMotion = false;
      #};
      # customize settings that not supported by nix-darwin directly
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        AppleShowAllExtensions = true; # show all file extensions
        #AppleEnableMouseSwipeNavigateWithScrolls = true;
        #AppleEnableSwipeNavigateWithScrolls = true;
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = false; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key

        AppleInterfaceStyle = "Dark"; # dark mode
        AppleKeyboardUIMode = 3; # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = true; # enable press and hold

        # Smooth scrolling
        NSScrollAnimationEnabled = true;

        # Autohide menu bar
        _HIHideMenuBar = true;

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        # 120, 94, 68, 35, 25, 15

        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        # 120, 90, 60, 30, 12, 6, 2

        KeyRepeat = 3; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false; # disable auto capitalization(自动大写)
        NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution(智能破折号替换)
        NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution(智能句号替换)
        NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution(智能引号替换)
        NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction(自动拼写检查)
        NSAutomaticWindowAnimationsEnabled = false;

        NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode2 = true;

        AppleTemperatureUnit = "Celsius";
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;

        # AppleInterfaceStyleSwitchesAutomatically = true;

        NSDocumentSaveNewDocumentsToCloud = false;
        AppleICUForce24HourTime = true;
        AppleShowAllFiles = true;
        "com.apple.keyboard.fnState" = false;
        # for the magic mouse
        # "com.apple.mouse.tapBehavior" = 1;

        "com.apple.sound.beep.volume" = 0.0;
      };

      # one space spans across all physical displays
      spaces.spans-displays = true;

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
          StandardHideDesktopIcons = 0; # Show items on desktop
          HideDesktop = 0; # Do not hide items on desktop & stage manager
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Downloads";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;

        # "com.apple.dock" = {"expose-group-apps" = true;};
      };

      loginwindow = {
        GuestEnabled = false; # disable guest user
        SHOWFULLNAME = true; # show full name in login window
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      alf.allowdownloadsignedenabled = 1;
    };

    # keyboard settings is not very useful on macOS
    # the most important thing is to remap option key to alt key globally,
    # but it's not supported by macOS yet.
    keyboard = {
      enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`

      # NOTE: do NOT support remap capslock to both control and escape at the same time
      remapCapsLockToControl = false; # remap caps lock to control, useful for emac users
      remapCapsLockToEscape = true; # remap caps lock to escape, useful for vim users

      # swap left command and left alt
      # so it matches common keyboard layout: `ctrl | command | alt`
      #
      # disabled, caused only problems!
      swapLeftCommandAndLeftAlt = false;
    };
  };

  # Add ability to used TouchID for sudo authentication
  # Enable sudo authentication with Touch ID
  security = {
    pam.services.sudo_local.touchIdAuth = true;
    sudo.extraConfig = "%admin ALL = (ALL) NOPASSWD: ALL";

  };
  # Enable linux builder VM.
  # This setting relies on having access to a cached version of the builder, since Darwin can't build it itself. The configuration options of the builder *can* be changed, but requires access to a (in this case) aarch64-linux builder to build. Hence on a new machine, or if there's any problems with the existing builder, the build fails.
  # For this reason, avoid changing the configuration options of linux-builder if at all possible.
  nix.linux-builder.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
    pkgs.nushell
  ];

  # Set your time zone.
  # comment this due to the issue:
  #   https://github.com/LnL7/nix-darwin/issues/359
  # time.timeZone = "Asia/shanghai";

  # Fonts
  fonts = {
    packages = with pkgs; [
      # packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      #    (nerd-fonts.override {
      #     fonts = [
      # symbols icon only
      #      "NerdFontsSymbolsOnly"
      # Characters
      #  "FiraCode"
      #  "JetBrainsMono"
      #  "Iosevka"
      #   ];
      # })
    ];
  };
}
