{
  config,
  lib,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.hypr;
  cfg = cfg'.lock;
in
{
  options.elysium.desktops.hypr.lock.enable = lib.mkEnableOption "Hyprlock" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    programs.hyprlock.enable = true;
  };
}
