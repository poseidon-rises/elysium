{
  chaos,
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.desktops.hyprland;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.desktops.desktops.hyprland = {
    enable = lib.mkEnableOption "Hyprland Window manager";

    workspaces = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
            };

            default = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };

            special = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };

            persist = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };

            monitor = lib.mkOption {
              type = lib.types.enum (lib.forEach chaos.monitors (monitor: monitor.connector));
              default = (lib.head chaos.monitors).connector;
            };
          };
        }
      );
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        inherit (cfg') exec-once;

        monitor =
          lib.forEach chaos.monitors (
            monitor:
            builtins.concatStringsSep ", " [
              monitor.connector
              "${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate}"
              "${toString monitor.x}x${toString monitor.y}"
              (toString monitor.scale)
            ]
          )
          ++ [ ", preferred, auto, auto" ];

        workspace = lib.forEach cfg.workspaces (
          workspace:
          builtins.concatStringsSep ", " (
            [
              (if workspace.special then "special:${workspace.name}" else "${workspace.name}")
              "monitor:${workspace.monitor}"
            ]
            ++ lib.optional workspace.persist "persistent:true"
            ++ lib.optional (workspace.monitor == (lib.head chaos.monitors).connector) "default:true"
          )
        );
      };

      xwayland.enable = true;
      systemd.enable = true;
    };

    assertions = [
      {
        assertion = (lib.lists.findSingle (monitor: monitor.default) false false cfg.workspaces) != false;
        message = "exactly one of `elysium.desktops.desktops.hyprland.workspaces.*` may set the default option";
      }
    ];
  };
}
