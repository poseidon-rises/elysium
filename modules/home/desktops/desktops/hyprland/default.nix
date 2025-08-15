{
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
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
    wayland.windowManager.hyprland = {
      enable = true;

      settings = { inherit (cfg') exec-once; };

      extraConfig = ''
        monitor=,preferred,auto,auto 
      '';

      xwayland.enable = true;
      systemd.enable = true;
    };
  };
}
