{ config, lib, ... }:

let
  cfg = config.elysium.services;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.services.serviceUser = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              default = name;
            };
          };
        }
      )
    );
  };

  config = {
    users.users =
      (builtins.mapAttrs (
        _: user: {
          name = "${user.name}-service";
          home = "/srv/${user.name}-serviceUser/home";
          group = "${user.name}-service";
          createHome = true;
          isSystemUser = true;
        }
      ))
        cfg.serviceUser;
    users.groups =
      (builtins.mapAttrs (
        _: user: {
          name = "${user.name}-service";
        }
      ))
        cfg.serviceUser;

  };
}
