{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  hostSpec = config.hostSpec;
  vauxhall = import (lib.elysium.relativeToRoot "vauxhall.nix");
in
{
  users.users.${hostSpec.username} = {
    isNormalUser = true;
    name = hostSpec.username;
    group = hostSpec.username;
    uid = 1000;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = lib.lists.forEach lib.filesystem.listFilesRecursive ./keys (
      key: builtins.readFile key
    );
  };

  users.groups.${hostSpec.username} = {
    gid = 1000;
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs vauxhall;
      hostSpec = config.hostSpec;
    };

    users.${hostSpec.username}.imports =
      lib.optional (!hostSpec.isMinimal) [
        (lib.elysium.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix")
        (lib.elysium.relativeToRoot "modules/home")
        inputs.zen-browser.homeModules.default
      ]
      |> lib.flatten;
  };
}
