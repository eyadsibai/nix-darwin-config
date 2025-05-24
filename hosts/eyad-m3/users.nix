# User configuration for eyad-m3
{ username, ... }:

{
  # Define user account
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  # Set trusted users for nix
  nix.settings.trusted-users = [ username ];

  # Set primary user for system
  system.primaryUser = username;
}
