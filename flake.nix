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
        self: super: {
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
    # ========== Nixpkgs ==========
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    master.url = "github:NixOS/nixpkgs/master";

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== NixOS modules ==========
    #
    disko = {
      # Declarative disk management
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== HM modules ==========
    #
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      # Neovim configuration in nix
      url = "github:NotAShelf/nvf/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      # Zen Browser package and modules
      url = "github:0xc000022070/zen-browser-flake/main";
      inputs.home-manager.follows = "home-manager";
    };

    #
    # ========== Secrets ==========
    #
    sops-nix = {
      # Nix secrets management
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      # Private repository with secrets
      url = "git+ssh://git@gitlab.com/elysium-mirror/elysium-secrets.git?ref=main&shallow=0";
      flake = false;
    };

    #
    # ========== Applications ==========
    #
    fenix = {
      # Rust toolchain manager
      url = "github:nix-community/fenix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tagstudio = {
      url = "github:TagStudioDev/TagStudio/main";
      # inputs.nixpkgs.follows = "nixpkgs"; Add back when
      # https://github.com/NixOS/nixpkgs/pull/437098 is added to unstable
    };
    #
    # ========== Utilities ==========
    #
    treefmt-nix = {
      # Formatter
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      # git hooks
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
