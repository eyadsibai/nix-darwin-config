{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  #  nixConfig = {
  #     substituters = [
  #     # Query the mirror of USTC first, and then the official cache.
  #     "https://mirrors.ustc.edu.cn/nix-channels/store"
  #     "https://cache.nixos.org"
  #   ];
  # };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";

      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    stylix.url = "github:danth/stylix";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    #  nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    stylix,
    nix-index-database,
    nixvim,
    # nix-homebrew,
    ...
  }: let
    username = "eyad";
    useremail = "eyad.alsibai@gmail.com";
    system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
    hostname = "${username}-m3";
    specialArgs =
      inputs
      // {
        inherit username useremail hostname nixvim;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix
        stylix.darwinModules.stylix
        {
          stylix.enable = true;
          stylix.image = ./wallpaper.png;
          stylix.polarity = "dark";
        }

        nix-index-database.darwinModules.nix-index
        # optional to also wrap and install comma
        {programs.nix-index-database.comma.enable = true;}

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.backupFileExtension = "bak";
          home-manager.users.${username} = import ./home;
        }
        #            nix-homebrew.darwinModules.nix-homebrew

        #	 {
        #     nix-homebrew = {
        # Install Homebrew under the default prefix
        #      enable = true;

        # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
        #            enableRosetta = true;
        #		autoMigrate= true;
        # User owning the Homebrew prefix
        #       user = "eyad";

        # Optional: Declarative tap management
        #            taps = {
        #             "homebrew/homebrew-core" = inputs.homebrew-core;
        #            "homebrew/homebrew-cask" = inputs.homebrew-cask;
        #         };

        # Optional: Enable fully-declarative tap management
        #
        # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
        #            mutableTaps = false;
        #    };
        #        }
        # ./modules/scripts.nix
      ];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
