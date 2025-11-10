{
  config,
  lib,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.hypr;
  cfg = cfg'.idle;
in
{
  options.elysium.desktops.hypr.idle.enable = lib.mkEnableOption "Hypridle" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    services.hypridle.enable = true;
  };
}
