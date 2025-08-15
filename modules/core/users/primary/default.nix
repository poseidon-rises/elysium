{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}:
let
  chaos = config.chaos;
  vauxhall = import (lib.elysium.relativeToRoot "vauxhall.nix");
in
{
  users.users.${chaos.username} = {
    isNormalUser = true;
    name = chaos.username;
    group = chaos.username;
    uid = 1000;
    extraGroups = [ "wheel" ];
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
      inherit inputs vauxhall;
      inherit (config) chaos;
    };

    users.${chaos.username}.imports =
      lib.optional (!lib.elem "Minimal" chaos.aspects) [
        (lib.elysium.relativeToRoot "home/${chaos.username}/${chaos.hostName}.nix")
        (lib.elysium.relativeToRoot "home/${chaos.username}/nysa")
        outputs.homeManagerModules.elysium
      ]
      |> lib.flatten;
  };
}
