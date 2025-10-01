{
  config,
  inputs,
  lib,
  outputs,
  ...
}:
let
  flakes = (lib.removeAttrs inputs [ "self" ]) // {
    elysium = inputs.self;
  };
in
{
  nixpkgs = {
    config = {
      permittedInsecurePackages = [ "SDL_ttf-2.0.11" ];
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "spotify"
          "aseprite"
          "steam"
          "steam-unwrapped"
        ];
    };
    overlays = [
      inputs.nur.overlays.default
      inputs.fenix.overlays.default
      outputs.overlays.default
    ];
  };

  nix = {
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakes;
    nixPath = lib.mapAttrsToList (n: v: "${n}=flake:${v}") flakes;
    settings = {
      nix-path = lib.mapAttrsToList (n: v: "${n}=flake:${v}") flakes;
      flake-registry = "";
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      auto-optimise-store = true;

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://notashelf.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "notashelf.cachix.org-1:VTTBFNQWbfyLuRzgm2I7AWSDJdqAa11ytLXHBhrprZk="
      ];
    };

    extraOptions = ''
      binary-caches-parallel-connections = 5
    '';
  };

  programs.nh = {
    enable = true;
    flake = "/home/${config.chaos.username}/.els";
  };
}
