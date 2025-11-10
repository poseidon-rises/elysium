{
  description = "Elysium";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        # "aarch64-linux"
      ];

      lib = nixpkgs.lib.extend (
        _self: _super: {
          elysium = import ./lib {
            inherit (nixpkgs) lib;
          };

          inherit (inputs.nvf.lib) nvim;
        }
      );

      pkgs = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            outputs.overlays.default
            inputs.nur.overlays.default
          ];
        }
      );

      vauxhall = import ./vauxhall.nix;
    in
    {
      nixosConfigurations =
        ./hosts/nixos
        |> builtins.readDir
        |> builtins.attrNames
        |> map (host: {
          name = host;
          value =
            lib.nixosSystem {
              specialArgs = {
                inherit
                  inputs
                  outputs
                  vauxhall
                  ;
              };
              modules = [
                ./hosts/nixos/${host}
                outputs.nixosModules.elysium
              ];
            }
            // {
              inherit inputs outputs vauxhall; # Add these to the repl environment
            };
        })
        |> builtins.listToAttrs;

      nixosModules.elysium.imports = [
        ./modules/core
        ./modules/chaos.nix
      ];

      homeModules.elysium.imports = [
        ./modules/home
      ];

      packages = forAllSystems (
        system:
        nixpkgs.lib.packagesFromDirectoryRecursive {
          callPackage = nixpkgs.lib.callPackageWith pkgs.${system};
          directory = ./pkgs/common;
        }
      );

      overlays = import ./overlays { inherit inputs; };

      formatter = forAllSystems (system: inputs.treefmt-nix.lib.mkWrapper pkgs.${system} ./treefmt.nix);

      devShells = forAllSystems (system: {
        default = outputs.devShells.${system}.nix-dev;
        nix-dev = import ./shell.nix {

          pkgs = pkgs.${system};
          checks = outputs.checks.${system};
          inherit lib;
        };
      });

      checks = forAllSystems (system: {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            treefmt = {
              enable = true;
              packageOverrides.treefmt = outputs.formatter.${system};
            };
            trim-trailing-whitespace.enable = true;
          };
        };
      });
    };

  inputs = {
    #
    # ========== Nix Packages ==========
    #
    # This imports larger collections of nixpkgs
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    master.url = "github:NixOS/nixpkgs/master";

    stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    nur = {
      # Community maintained NUR repository
      url = "github:nix-community/nur";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    fenix = {
      # Packages for the Rust toolchain
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== NixOS Modules ==========
    #
    # NixOS modules needed for system configuration and management
    #
    disko = {
      # Declarative disk management
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== HM Modules ==========
    #
    # Home Manager modules needed for user config management
    #
    home-manager = {
      # Manage user specific configuration
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      # Neovim configuration in nix
      url = "github:NotAShelf/nvf/v0.8";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        systems.follows = "systems";
      };
    };

    zen-browser = {
      # Zen Browser package and modules
      url = "github:0xc000022070/zen-browser-flake/main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    #
    # ========== Secrets ==========
    #
    # Flakes needed for secrets management
    #
    sops-nix = {
      # Nix secrets management
      url = "github:mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      # Private repository with encrypted secrets
      url = "git+ssh://git@gitlab.com/elysium-mirror/elysium-secrets.git?ref=main&shallow=0";
      flake = false;
    };

    #
    # ========== Applications ==========
    #
    # Inputs that add a single app or package
    #
    tagstudio = {
      # TagStudio, a file management software
      url = "github:TagStudioDev/TagStudio/main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };

    #
    # ========== Flake ==========
    #
    # Inputs used to manage the flake
    #
    treefmt-nix = {
      # Formatter
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      # Git hooks
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "systems";
      };
    };

    #
    # ========== Shared Dependencies ==========
    #
    # These are flakes that other inputs use more than once, so we share them to
    # minimize disk usage
    #
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-compat.url = "github:edolstra/flake-compat";

    systems.url = "github:nix-systems/default";
  };
}
