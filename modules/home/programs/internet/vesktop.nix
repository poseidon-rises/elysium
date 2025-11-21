{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.programs.internet;
  cfg = cfg'.vesktop;
in
{
  options.elysium.programs.internet.vesktop.enable = lib.mkEnableOption "Vesktop client" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.vesktop.enable = true;
  };
}
