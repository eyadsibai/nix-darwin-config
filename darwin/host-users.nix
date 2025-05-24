{ username
, hostname
, ...
}:
#let
# blockedDomains = ''
#   127.0.0.1 apresolve.spotify.com
# ''; in
{
  #  system.activationScripts.blockHosts = {
  #    text = ''
  #      echo "$blockedDomains" | sudo tee -a /etc/hosts
  #    '';
  # };
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [ username ];
}
