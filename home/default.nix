{
 pkgs,
  nixvim,
  username,
  ...
}: {
  # import sub modules
  imports = [
    nixvim.homeManagerModules.nixvim
    ./shell.nix
    ./core.nix
    ./git.nix
    ./starship.nix
    ./nixvim.nix
  ];

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.".config/aerospace/aerospace.toml" = {source = ./aerospace.toml;};
#   home.file.".config/sketchybar/sketchybarrc" = {source = ./sketchybar/sketchybarrc;};
# 	home.file.".config/sketchybar/plugins" = {
#   source = ./sketchybar/plugins;
#   recursive = true;
# };
	home.file.".config/sketchybar" = {
  source = ./sketchybar;
  recursive = true;
};
}
