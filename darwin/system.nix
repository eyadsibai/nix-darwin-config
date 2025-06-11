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
{ pkgs
, username
, hostname
, ...
}:

let
  # Define domains to block by redirecting them to localhost
  blockedDomains = ''
    127.0.0.1 apresolve.spotify.com
  '';
in

{
  # Set the nix-darwin state version for compatibility
  system.stateVersion = 5;

  # Additional security settings
  security = {
    pam =
      {
        # Enable Touch ID for local user authentication
        services.sudo_local.touchIdAuth = true;
      };
    # Allow admin users to run sudo without password prompt
    sudo.extraConfig = "%admin ALL = (ALL) NOPASSWD: ALL";
  };

  # Create launch daemon to increase file descriptor limits to 524,288
  environment.launchDaemons."limit.maxfiles.plist" = {
    enable = true;
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
      <key>Label</key>
      <string>limit.maxfiles</string>
      <key>ProgramArguments</key>
      <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>524288</string>
      <string>524288</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>ServiceIPC</key>
      <false/>
      </dict>
      </plist>
    '';
  };

  system = {
    # Set the primary user account
    primaryUser = "eyad";

    defaults = {
      # Show 24-hour format in menu bar clock
      menuExtraClock.Show24Hour = true;

      # Trackpad configuration
      trackpad = {
        # Enable tap-to-click functionality
        Clicking = true;
        # Enable two-finger right-click
        TrackpadRightClick = true;
        # Enable three-finger drag gesture
        TrackpadThreeFingerDrag = true;
        # Set trackpad click strength to 0 (silent clicking)
        ActuationStrength = 0;
      };

      # Finder configuration
      finder = {
        # Show POSIX path in Finder window title
        _FXShowPosixPathInTitle = true;
        # Show all file extensions
        AppleShowAllExtensions = true;
        # Disable warning when changing file extensions
        FXEnableExtensionChangeWarning = false;
        # Enable "Quit Finder" menu item
        QuitMenuItem = true;
        # Show path bar at bottom of Finder windows
        ShowPathbar = true;
        # Show status bar at bottom of Finder windows
        ShowStatusBar = true;
        # Show hidden files and folders
        AppleShowAllFiles = true;
        # Don't create desktop icons
        CreateDesktop = false;
        # Search current folder by default
        FXDefaultSearchScope = "SCcf";
      };

      # Dock configuration
      dock = {
        # Auto-hide the dock
        autohide = true;
        # Set auto-hide delay to 0 seconds
        autohide-delay = 0.0;
        # Hide recent applications section
        show-recents = false;
        # Set dock position to bottom of screen
        orientation = "bottom";
        # Hide app running indicators
        show-process-indicators = false;
        # Show only active applications
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

        # Hot corner settings (1 = Disabled for all corners)
        wvous-tl-corner = 1; # Top-left corner
        wvous-tr-corner = 1; # Top-right corner  
        wvous-bl-corner = 1; # Bottom-left corner
        wvous-br-corner = 14; # Bottom-right corner

        # Set dock icon size to 32 pixels
        tilesize = 50;
        # Show Dashboard as overlay instead of separate space
        dashboard-in-overlay = true;
        # Don't arrange spaces by most recent use
        mru-spaces = false;
        # Disable app launch animations
        launchanim = false;
      };

      # Global system domain settings
      NSGlobalDomain = {
        # Show all file extensions globally
        AppleShowAllExtensions = true;
        # Disable natural scrolling (reverse scroll direction)
        "com.apple.swipescrolldirection" = false;
        # Disable beep feedback when adjusting volume
        "com.apple.sound.beep.feedback" = 0;
        # Set system appearance to dark mode
        AppleInterfaceStyle = "Dark";
        # Enable full keyboard access for all controls
        AppleKeyboardUIMode = 3;
        # Enable press and hold for accented characters
        ApplePressAndHoldEnabled = true;
        # Enable smooth scrolling animations
        NSScrollAnimationEnabled = true;
        # Don't auto-hide menu bar
        _HIHideMenuBar = false;
        # Set initial key repeat delay (15 = 225ms)
        # minimum is 15 (225 ms), maximum is 120 (1800 ms)
        InitialKeyRepeat = 13;
        # Set key repeat rate (3 = 45ms between repeats)
        # minimum is 2 (30 ms), maximum is 120 (1800 ms)
        KeyRepeat = 2;
        # Disable automatic capitalization
        NSAutomaticCapitalizationEnabled = false;
        # Disable smart dash substitution
        NSAutomaticDashSubstitutionEnabled = false;
        # Disable smart period substitution
        NSAutomaticPeriodSubstitutionEnabled = false;
        # Disable smart quote substitution
        NSAutomaticQuoteSubstitutionEnabled = false;
        # Disable spell checking
        NSAutomaticSpellingCorrectionEnabled = false;
        # Disable window animations
        NSAutomaticWindowAnimationsEnabled = false;
        # Expand save dialogs by default
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        # Use Celsius for temperature
        AppleTemperatureUnit = "Celsius";
        # Use centimeters for measurements
        AppleMeasurementUnits = "Centimeters";
        # Use metric units
        AppleMetricUnits = 1;
        # Don't save new documents to iCloud by default
        NSDocumentSaveNewDocumentsToCloud = false;
        # Force 24-hour time format
        AppleICUForce24HourTime = true;
        # Show all files globally
        AppleShowAllFiles = true;
        # Disable function key behavior (F1, F2, etc. work as function keys)
        "com.apple.keyboard.fnState" = false;
        # Disable system beep sound
        "com.apple.sound.beep.volume" = 0.0;
      };

      # Make spaces span across all displays
      spaces.spans-displays = true;

      # Custom user preferences for specific applications
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          # Switch to application's space when activating it
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          # Enable Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          # Show external drives on desktop
          ShowExternalHardDrivesOnDesktop = true;
          # Show hard drives on desktop
          ShowHardDrivesOnDesktop = true;
          # Show network servers on desktop
          ShowMountedServersOnDesktop = true;
          # Show removable media on desktop
          ShowRemovableMediaOnDesktop = true;
          # Sort folders first in Finder
          _FXSortFoldersFirst = true;
          # Search current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Don't create .DS_Store files on network volumes
          DSDontWriteNetworkStores = true;
          # Don't create .DS_Store files on USB volumes
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          # Each display has separate spaces (0 = separate, 1 = spans displays)
          "spans-displays" = 0;
        };
        "com.apple.WindowManager" = {
          # Disable click wallpaper to show desktop
          EnableStandardClickToShowDesktop = 0;
          # Show desktop icons
          StandardHideDesktopIcons = 0;
          # Don't hide desktop items
          HideDesktop = 0;
          # Don't hide widgets in Stage Manager
          StageManagerHideWidgets = 0;
          # Don't hide widgets normally
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
          # Require password after screensaver starts
          askForPassword = 1;
          # Require password immediately (0 second delay)
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          # Save screenshots to Downloads folder
          location = "~/Downloads";
          # Save screenshots as PNG files
          type = "png";
        };
        "com.apple.AdLib" = {
          # Disable personalized advertising
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos app from auto-opening when devices are connected
        "com.apple.ImageCapture".disableHotPlug = true;
      };

      # Login window settings
      loginwindow = {
        # Disable guest user account
        GuestEnabled = false;
        # Show full names instead of usernames
        SHOWFULLNAME = true;
      };

      # Automatically install macOS updates
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      # Enable firewall for downloaded signed applications
      alf.allowdownloadsignedenabled = 1;
    };

    # Keyboard configuration
    keyboard = {
      # Enable key mapping functionality
      enableKeyMapping = true;
      # Don't remap Caps Lock to Control
      remapCapsLockToControl = false;
      # Remap Caps Lock to Escape (useful for Vim users)
      remapCapsLockToEscape = true;
      # Don't swap Command and Alt keys
      swapLeftCommandAndLeftAlt = false;
    };

    # Script to block domains by adding them to /etc/hosts
    activationScripts.blockHosts = {
      text = ''
        echo "${blockedDomains}" | sudo tee -a /etc/hosts
      '';
    };
  };

  # Enable Linux builder VM for cross-platform builds
  nix.linux-builder.enable = true;

  # Enable and configure Zsh shell
  programs.zsh.enable = true;
  # Available shell options
  environment.shells = [
    pkgs.zsh # Z shell
    pkgs.nushell # Nu shell
  ];

  # Install fonts
  fonts = {
    packages = with pkgs; [
      # Icon and symbol fonts
      material-design-icons
      font-awesome

      # Nerd Fonts (programming fonts with icons)
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.fira-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu
      nerd-fonts.hack
      nerd-fonts.meslo-lg
      nerd-fonts.caskaydia-cove

      # Additional fonts
      source-code-pro
      sketchybar-app-font
    ];
  };

  # Network configuration
  networking.hostName = hostname; # Set system hostname
  networking.computerName = hostname; # Set computer name
  system.defaults.smb.NetBIOSName = hostname; # Set NetBIOS name for SMB

  # User account configuration
  users.users."${username}" = {
    home = "/Users/${username}"; # Set user home directory
  };

  # Home Manager configuration for the user
  home-manager.users.${username} = {
    home = {
      username = username; # Set username
      homeDirectory = "/Users/${username}"; # Set home directory path
      stateVersion = "23.11"; # Home Manager compatibility version
    };
  };

  # Allow the specified user to use Nix trusted features
  nix.settings.trusted-users = [ username ];
}
