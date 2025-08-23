{
  config,
  inputs,
  lib,
  outputs,
  ...
}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "SDL_ttf-2.0.11" ];
    };
    overlays = [
      inputs.nur.overlays.default
      inputs.fenix.overlays.default
      outputs.overlays.default
    ];
  };

  nix = {
    channel.enable = false;
    registry =
      let
        flakes = (lib.removeAttrs inputs [ "self" ]) // {
          elysium = inputs.self;
        };
      in
      lib.mapAttrs (_: flake: { inherit flake; }) flakes;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
    settings = {
      nix-path = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
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
