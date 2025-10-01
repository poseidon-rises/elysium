{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development.tools;
  cfg = cfg'.sqlite;
in
{
  options.elysium.development.tools.sqlite.enable = lib.mkEnableOption "SQLite" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.sqlite ];
  };
}
