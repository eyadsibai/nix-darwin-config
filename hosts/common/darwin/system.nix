# macOS System Configuration
{ pkgs, ... }:

{
  system = {
    defaults = {
      # Menu bar clock
      menuExtraClock.Show24Hour = true;

      # Dock configuration
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        show-recents = false;
        orientation = "bottom";
        show-process-indicators = false;
        static-only = true;
        tilesize = 32;
        dashboard-in-overlay = true;
        mru-spaces = false;
        launchanim = false;

        # Hot Corners (all disabled by default)
        wvous-tl-corner = 1; # top-left
        wvous-tr-corner = 1; # top-right
        wvous-bl-corner = 1; # bottom-left
        wvous-br-corner = 1; # bottom-right
      };

      # Finder configuration
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
      };

      # Trackpad configuration
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        ActuationStrength = 0; # Silent clicking
      };

      # Global system preferences
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        "com.apple.swipescrolldirection" = false; # Disable natural scrolling
        "com.apple.sound.beep.feedback" = 0;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3; # Full keyboard control
        ApplePressAndHoldEnabled = true;
        NSScrollAnimationEnabled = true;
        _HIHideMenuBar = true; # Auto-hide menu bar

        # Key repeat settings
        InitialKeyRepeat = 15;
        KeyRepeat = 3;

        # Disable auto-corrections
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;

        # Save panel settings
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;

        # Units and measurements
        AppleTemperatureUnit = "Celsius";
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;

        NSDocumentSaveNewDocumentsToCloud = false;
        AppleICUForce24HourTime = true;
        AppleShowAllFiles = true;
        "com.apple.keyboard.fnState" = false;
        "com.apple.sound.beep.volume" = 0.0;
      };

      # Spaces configuration
      spaces.spans-displays = true;

      # Custom user preferences
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0;
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0;
          StandardHideDesktopIcons = 0;
          HideDesktop = 0;
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
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
        "com.apple.ImageCapture".disableHotPlug = true;
      };

      # Login window settings
      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = true;
      };

      # Software update settings
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      alf.allowdownloadsignedenabled = 1;
    };

    # Keyboard settings
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = false;
      remapCapsLockToEscape = true;
      swapLeftCommandAndLeftAlt = false;
    };
  };
}
