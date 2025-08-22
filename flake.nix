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
        #"aarch64-linux"
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
          overlays = [ outputs.overlays.default ];
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

      devShell = forAllSystems (
        system:
        import ./shell.nix {
          pkgs = pkgs.${system};
          checks = outputs.checks.${system};
          inherit lib;
        }
      );

      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
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

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    master.url = "github:NixOS/nixpkgs/master";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.home-manager.follows = "home-manager";
    };

    fenix = {
      url = "github:nix-community/fenix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      url = "git+ssh://git@gitlab.com/elysium-mirror/elysium-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };
}
