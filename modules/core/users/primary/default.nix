{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  self,
  ...
}:
let
  inherit (config) chaos;
  vauxhall = import (lib.elysium.relativeToRoot "vauxhall.nix");

  cfg = config.elysium.users.users.primary;

  ifGroupsExists = groups: lib.filter (group: lib.hasAttr group config.users.groups) groups;
in
{
  options.elysium.users.users.primary.enable = lib.mkEnableOption "primary user" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    users.users.${chaos.username} = {
      isNormalUser = true;
      name = chaos.username;
      group = chaos.username;
      uid = 1000;
      extraGroups = [
        "wheel"
      ]
      ++ ifGroupsExists [
        "nix"
        "audio"
        "video"
        "networkmanager"
        # For print/scan
        "scanner"
        "lp"
      ];

      shell = pkgs.fish;

      openssh.authorizedKeys.keys = lib.lists.forEach lib.filesystem.listFilesRecursive ./keys (
        key: builtins.readFile key
      );
    };

    users.groups.${chaos.username} = {
      gid = 1000;
    };

    home-manager = {
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          vauxhall
          self
          ;
        inherit (config) chaos;
      };

      users.${chaos.username}.imports =
        lib.optional (!lib.elem "Minimal" chaos.aspects) [
          (lib.elysium.relativeToRoot "home/${chaos.username}/${chaos.hostName}.nix")
          (lib.elysium.relativeToRoot "home/${chaos.username}/nysa")
        ]
        |> lib.flatten;
    };
  };
}
