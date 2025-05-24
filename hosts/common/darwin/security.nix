# Security and authentication configuration
{ ... }:

{
  security = {
    # Enable TouchID for sudo authentication
    pam.services.sudo_local.touchIdAuth = true;
    
    # Allow admin users to use sudo without password
    sudo.extraConfig = "%admin ALL = (ALL) NOPASSWD: ALL";
  };
}
