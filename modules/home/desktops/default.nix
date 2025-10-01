{
  config,
  chaos,
  lib,
  ...
}:

let
  cfg = config.elysium.desktops;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "desktops" ] {
      name = "default";
      default = "hyprland";
      example = "hyprland";
      description = "Default desktop to use.";
    })
  ]
  ++ lib.elysium.scanPaths ./.;

  options.elysium.desktops = {
    enable = lib.mkEnableOption "desktops" // {
      default = lib.elem "Graphical" chaos.aspects;
    };

    exec-once = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            command = lib.mkOption {
              type = lib.types.str;
            };

            args = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
            };
          };
        }
      );
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.portal.xdgOpenUsePortal = true;

    systemd.user.services = builtins.mapAttrs (_name: command: {
      Install = {
        WantedBy = [ "xdg-desktop-autostart.target" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${command.command} ${lib.concatStringsSep " " command.args}";
      };
    }) cfg.exec-once;
  };
}
