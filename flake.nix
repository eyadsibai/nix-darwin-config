{
  description = "Ultimate Nix Darwin Configuration for Multiple Devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    # Home Manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin for macOS system configuration
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix for system theming
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix index database for command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim for Neovim configuration
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixvim";
    };
  };

  outputs = inputs @ { self, nixpkgs, darwin, home-manager, stylix, nix-index-database, nixvim, ... }:
    let
      # User configuration
      username = "eyad";
      useremail = "eyad.alsibai@gmail.com";
      system = "aarch64-darwin";
      
      # Host configurations
      hosts = {
        "eyad-m3" = {
          hostname = "eyad-m3";
          system = "aarch64-darwin";
        };
        # Add more hosts here as needed
        # "eyad-air" = {
        #   hostname = "eyad-air";
        #   system = "aarch64-darwin";
        # };
      };

      # Common special args passed to all modules
      mkSpecialArgs = hostname: inputs // {
        inherit username useremail hostname;
      };

      # Function to create a Darwin configuration for a host
      mkDarwinConfiguration = hostName: hostConfig:
        darwin.lib.darwinSystem {
          inherit (hostConfig) system;
          specialArgs = mkSpecialArgs hostConfig.hostname;
          modules = [
            # Host-specific configuration
            ./hosts/${hostName}

            # Stylix theming
            stylix.darwinModules.stylix
            {
              stylix.enable = false;
              stylix.image = ./wallpaper.png;
              stylix.polarity = "dark";
            }

            # Nix index database
            nix-index-database.darwinModules.nix-index
            {
              programs.nix-index-database.comma.enable = true;
            }

            # Home Manager integration
            home-manager.darwinModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = mkSpecialArgs hostConfig.hostname;
              home-manager.backupFileExtension = "bak";
              home-manager.users.${username} = ./hosts/${hostName}/home.nix;
            }
          ];
        };
    in
    {
      # Darwin configurations for each host
      darwinConfigurations = builtins.mapAttrs mkDarwinConfiguration hosts;

      # Nix code formatter
      formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

      # Development shell
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          just
          nixpkgs-fmt
          statix
        ];
      };
    };
}
