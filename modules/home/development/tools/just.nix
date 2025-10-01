{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development.tools;
  cfg = cfg'.just;
in
{
  options.elysium.development.tools.just.enable = lib.mkEnableOption "Just command runner" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.just ];
  };
}
