{ username
, hostname
, ...
}:
let
  blockedDomains = ''
    127.0.0.1 apresolve.spotify.com
  '';
in
{
  system.activationScripts.blockHosts = {
    text = ''
      echo "${blockedDomains}" | sudo tee -a /etc/hosts
    '';
  };
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
  };

  home-manager.users.${username} = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
      username = username;
      homeDirectory = "/Users/${username}";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "23.11";
    };
  };

  nix.settings.trusted-users = [ username ];
}
