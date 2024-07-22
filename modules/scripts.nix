{pkgs, ...}: {
  environment.etc."set_spaces.applescript".text = ''
    tell application "System Events"
        tell spaces preferences
            set currentSpaces to (count of spaces)
            set targetSpaces to 4 -- Replace 4 with the desired number of spaces

            if currentSpaces < targetSpaces then
                repeat while (currentSpaces < targetSpaces)
                    set currentSpaces to currentSpaces + 1
                    do shell script "open -a 'System Preferences'"
                    delay 1
                    tell application "System Events" to tell process "System Preferences"
                        click button "Mission Control" of tab group 1 of window "System Preferences"
                    end tell
                    delay 1
                    tell application "System Events"
                        keystroke (ASCII character 30) using {control down}
                    end tell
                    delay 1
                    do shell script "killall 'System Preferences'"
                end repeat
            else if currentSpaces > targetSpaces then
                repeat while (currentSpaces > targetSpaces)
                    set currentSpaces to currentSpaces - 1
                    do shell script "open -a 'System Preferences'"
                    delay 1
                    tell application "System Events" to tell process "System Preferences"
                        click button "Mission Control" of tab group 1 of window "System Preferences"
                    end tell
                    delay 1
                    tell application "System Events"
                        keystroke (ASCII character 31) using {control down}
                    end tell
                    delay 1
                    do shell script "killall 'System Preferences'"
                end repeat
            end if
        end tell
    end tell
  '';

  # # Define the launchd service
  launchd.daemons."set-spaces" = {
    serviceConfig = {
      Program = "/usr/bin/osascript";
      ProgramArguments = ["/etc/set_spaces.applescript"];
      KeepAlive = false;
      RunAtLoad = true;
      StandardOutPath = "/var/log/set_space.log";
      StandardErrorPath = "/var/log/set_space.log";
    };
  };
}
