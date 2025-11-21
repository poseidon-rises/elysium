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
  options.elysium.desktops.desktops.hyprland = {
    enable = lib.mkEnableOption "Hyprland Window manager";

    workspaces = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            id = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
            };

            name = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
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
      default = lib.forEach (lib.range 1 10) (id: {
        inherit id;
        default = id == 1;
      });
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = [ ", preferred, auto, auto" ];

        workspace = lib.forEach cfg.workspaces (
          workspace:
          lib.concatStringsSep ", " (
            [
              (
                if (workspace.name == null) then
                  toString workspace.id
                else if workspace.special then
                  "special:${workspace.name}"
                else
                  "name:${workspace.name}"
              )

              "persistent:${if workspace.persist then "true" else "false"}"
            ]
            ++ lib.optional (lib.any (_: true) chaos.monitors) "monitor:${workspace.monitor}"
          )
        );

        monitorv2 = lib.forEach chaos.monitors (monitor: {
          output = monitor.connector;
          mode = "${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate}";
          position = "${toString monitor.x}x${toString monitor.y}";
          scale = "${toString monitor.scale}";
        });
      };

      xwayland.enable = true;
      systemd.enable = true;
    };

    assertions = [
      {
        assertion = lib.any (f: f) (
          lib.forEach chaos.monitors (
            _: lib.lists.findSingle (workspace: workspace.default) false null cfg.workspaces == null
          )
        );
        message = "exactly one of `elysium.desktops.desktops.hyprland.workspaces.*` may set the default optional per monitor";
      }
      {
        assertion = builtins.all (
          workspace: (workspace.id == null) != (workspace.name == null)
        ) cfg.workspaces;
        message = "every elysium.desktops.desktops.hyprland.workspaces.* must set exactly one of 'name' or 'id'";
      }
    ];
  };
}
